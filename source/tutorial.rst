
*This notebook can be found on*
`github <https://github.com/bastikr/QuantumOptics.jl/blob/master/docs/tutorial.ipynb>`__

Tutorial
========

In this tutorial we will step through the common tasks necessary to
simulate a quantum system. At each step links will provided to
documentation and examples that explain the topic in more detail.

In order to use the **QuantumOptics.jl** library it has to be loaded
into the current workspace.

.. code:: julia

    using QuantumOptics

Bases
-----

The first step is always to define a suitable basis for the quantum
system under consideration. For example a Fock basis can be used to
describe a field mode. It takes an Integer as argument which specifies
the photon number cutoff.

.. code:: julia

    b = FockBasis(20);

Many quantum systems are already implemented: \* Fock bases \* Spins \*
Particles \* N-level systems \* Many-body systems

States and Operators
--------------------

Functions that create the typical operators and states in these bases
are provided.

.. code:: julia

    a = destroy(b)
    at = create(b)
    
    alpha = 1.5
    psi = coherentstate(b, alpha);

They can be combined in all the expected ways.

.. code:: julia

    dpsi = -1im*(a + at)*psi;

The **dagger()** function can be used to transform a ket state into a
bra state which for example can be used to create a density operator

.. code:: julia

    rho = psi ⊗ dagger(psi);

or to calculate expectation values.

.. code:: julia

    println(dagger(psi)*a*psi)


.. parsed-literal::

    1.

Alternatively. the **expect()** function can be used.

.. code:: julia

    println(expect(a, psi))


.. parsed-literal::

    1.4999999999991955 + 0.0im


Composite systems
-----------------

Most interesting quantum systems consist of several different parts, for
example two spins coupled to a cavity mode.

.. code:: julia

    ω_atom = 2
    ω_field = 1
    
    # 2 level atom described as spin
    b_spin = SpinBasis(1//2)
    sp = sigmap(b_spin)
    sm = sigmam(b_spin)
    
    H_atom = ω_atom*sp*sm
    
    # Use a Fock basis with a maximum of 20 photons to model a cavity mode
    b_fock = FockBasis(20)
    a = destroy(b_fock)
    at = create(b_fock)
    n = number(b_fock)
    
    H_field = ω_field*n;

Combining operators from those two systems can be done with the
**tensor()** function or with the equivalent :math:`\otimes` operator.

.. code:: julia

    Ω = 1
    H_int = Ω*(a ⊗ sp + at ⊗ sm);

To extend the single system Hamiltonians :math:`H_{atom}` and
:math:`H_{spin}` to the composite system Hilbert space, one possibility
is to combine them whith identity operators from the oposite sub-system.

.. code:: julia

    I_field = identityoperator(b_fock)
    I_atom = identityoperator(b_spin)
    
    H_atom_ = I_field ⊗ H_atom
    H_field_ = I_atom ⊗ H_field;

However, especially for larger systems this can become tedious and it's
more convenient to use the **embed()** function.

.. code:: julia

    b = b_fock ⊗ b_spin # Basis of composite system
    
    H = embed(b, 1, H_field) + embed(b, 2, H_atom) + H_int;

Creating composite states works completely the same.

.. code:: julia

    ψ0 = fockstate(b_fock, 1) ⊗ spindown(b_spin);

Time evolution
--------------

Several different types of time evolution are implemented in
**QuantumOptics.jl** \* schroedinger \* master \* mcwf

All of them share a very similar interface so that changing from one to
another is mostly done by changing the function name:

::

    schroedinger(T, psi0, H)
    master(T, psi0/rho0, H, J)
    mcwf(T, psi0, H, J)

They all return two vectors ``tout`` and ``states``.

Schrödinger equation
~~~~~~~~~~~~~~~~~~~~

Let's now analyze the dynamics of the system according to the
Schrödinger equation.

.. code:: julia

    T = [0:0.05:5;]
    tout, ψt = timeevolution.schroedinger(T, ψ0, H);

The results can be visualized using for example matplotlib.

.. code:: julia

    using PyPlot
    
    figure(figsize=[10, 3])
    
    subplot(1, 2, 1)
    xlabel("Time")
    ylabel(L"$\langle |e\rangle \langle e| \rangle$")
    plot(tout, expect(2, sp*sm, ψt))
    
    subplot(1, 2, 2)
    xlabel("Time")
    ylabel(L"$\langle n \rangle$")
    plot(tout, expect(1, n, ψt));



.. image:: tutorial_files/tutorial_31_0.png


Master equation
~~~~~~~~~~~~~~~

Let's now add photon loss to the cavity by introducing a jump operator
:math:`a`. This means the system is now an open quantum system and is
described by a master equation.

.. code:: julia

    κ = 1.
    J = [embed(b, 1, a)]
    tout, ρt = timeevolution.master(T, ψ0, H, J; Gamma=[κ]);
    
    figure(figsize=[10, 3])
    
    subplot(1, 2, 1)
    xlabel("Time")
    ylabel(L"$\langle |e\rangle \langle e| \rangle$")
    plot(tout, expect(2, sp*sm, ρt))
    
    subplot(1, 2, 2)
    xlabel("Time")
    ylabel(L"$\langle n \rangle$")
    plot(tout, expect(1, n, ρt));



.. image:: tutorial_files/tutorial_33_0.png


Monte Carlo wave function
~~~~~~~~~~~~~~~~~~~~~~~~~

Alternatively, one can use the MCWF method to analyze the time evolution
of the system. Physically, it can be interpreted as an experimental
setup where every photon leaving the cavity is meassured by a photon
counter, thereby projecting the system onto the state
:math:`| \psi\rangle \rightarrow a |\psi\rangle`. This leads to a
coherent time evolution according to a schroedinger equation interrupted
by these jumps at certain random points in time.

.. code:: julia

    figure(figsize=[10, 3])
    
    subplot(1, 2, 1)
    xlabel("Time")
    ylabel(L"$\langle |e\rangle \langle e| \rangle$")
    
    subplot(1, 2, 2)
    xlabel("Time")
    ylabel(L"$\langle n \rangle$")
    
    tout, ψt_mcwf = timeevolution.mcwf(T, ψ0, H, J; seed=UInt(0),
                                       display_beforeevent=true,
                                       display_afterevent=true);
    subplot(1, 2, 1)
    plot(tout, expect(2, sp*sm, ψt_mcwf))
    subplot(1, 2, 2)
    plot(tout, expect(1, n, ψt_mcwf));



.. image:: tutorial_files/tutorial_35_0.png


In the statistical average the MCWF time evolution is equaivalent to the
time evolution according to the master equation.

.. code:: julia

    Ntrajectories = 10
    
    exp_n = zeros(Float64, length(T))
    exp_e = zeros(Float64, length(T))
    
    function fout(t, psi)
        i = findfirst(T, t)
        N = norm(psi)
        exp_e[i] += real(expect(2, sp*sm, normalize(psi)))
        exp_n[i] += real(expect(1, n, normalize(psi)))
    end
    
    srand(0)
    for i=1:Ntrajectories
        timeevolution.mcwf(T, ψ0, H, J; fout=fout)
    end
    
    figure(figsize=[10, 3])
    
    subplot(1, 2, 1)
    plot(T, expect(2, sp*sm, ρt))
    plot(T, exp_e/Ntrajectories)
    
    subplot(1, 2, 2)
    plot(T, expect(1, n, ρt))
    plot(T, exp_n/Ntrajectories);



.. image:: tutorial_files/tutorial_37_0.png


