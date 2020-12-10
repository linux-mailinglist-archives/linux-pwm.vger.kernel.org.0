Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54C2D6327
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392579AbgLJRLo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 12:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392580AbgLJRLa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 12:11:30 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500D7C0613D6;
        Thu, 10 Dec 2020 09:10:49 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b73so6294000edf.13;
        Thu, 10 Dec 2020 09:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xAG6Zv0gDmGbv2Z41zUPmXjqkSMZ8NZNRJVCYh44aIE=;
        b=KORZuGC2K/FBgZ7kRYRhwL87dZlYh2l46e6V80FoC/a/ywvUyOfObNSIR0RvaPqbSG
         cVz4m5PhbZdUf4XwEiCQbIX0qWZAdpTJQA+KNHfDeyINp7f1nNDqmoPlVMYRHHC7yFSd
         hd7KBNxLu1rS4QhnC+pXR/juY6mJEAvS435UVqHEzI+vJDaMf/O+dWQf/R5URjebU2za
         bkMNyYvrwAJsdZtDeXltWyf1zuVJ8k7GMKeNGZr0hw0Gv2ql+kMoZo3Hh9aB4pfJ1v+Y
         IQ8gyArcUwTyVbA6Jqti2Za0shwOkSCjM+24SvcmqjpGg3qTLcuyEMc5feAxojv3sRpf
         w2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xAG6Zv0gDmGbv2Z41zUPmXjqkSMZ8NZNRJVCYh44aIE=;
        b=Y3EngQzTCNGuxwbEmmEMLLXCU+wnfP3sqdHeOBAjN3Tw0iuQfi7v/Bg24lu6FeZekT
         1PmzonxwHd7Zzmsk9zboLZB8GvWrPrl0exLfr5JMWeut3dm1RwzsnmSy7pdsLe86rwMa
         kraDMFxIOC2auPKvqrWN4SGc8LdL6Ge9TCfkasWQ/vTO0fJfQixwrZmNxqSCmEzfufZO
         artx+FpA/21me8NgE4zxaCcPbB4O375apZuTnwsQE0Ehp0Ub2LHDKVYW8pJvtyZCLsNT
         hWJsSt1jDCXvdI400H1jlfXku7nTLkb7cvlMu5TN1SSD/4pmwjZKJYbaJxpuEDrFXkhh
         F2xw==
X-Gm-Message-State: AOAM531aut9sV991ilxh46SJm1dSs6oeG6tgylrpdac6cRy4LPYn1UKy
        a8R/NG4oXIZpQeBkcrN9ygo=
X-Google-Smtp-Source: ABdhPJxiNiyk1TGXiVLwFZMPUpaa9pEI+ctBai+MVo8azHQTKS+LOzwxHB3miOe6AM2BnSpBj4/CgA==
X-Received: by 2002:a05:6402:1a54:: with SMTP id bf20mr7808853edb.65.1607620247934;
        Thu, 10 Dec 2020 09:10:47 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id rh2sm4828310ejb.68.2020.12.10.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:10:46 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:10:45 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <X9JWlVPb9ZGdB4q9@ulmo>
References: <20201207220025.42b6g76wq7ph5nvb@pengutronix.de>
 <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1KsO48xkyUADVIL+"
Content-Disposition: inline
In-Reply-To: <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--1KsO48xkyUADVIL+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 10:01:24AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Wed, Dec 09, 2020 at 06:02:16PM +0100, Thierry Reding wrote:
> > On Tue, Dec 08, 2020 at 07:26:37PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello Thierry, hello Sven,
> > >=20
> > > On Tue, Dec 08, 2020 at 05:57:12PM +0100, Thierry Reding wrote:
> > > > On Tue, Dec 08, 2020 at 09:44:42AM -0500, Sven Van Asbroeck wrote:
> > > > > Which brings us to an even trickier question: what happens if a p=
wm output
> > > > > is set to 0% or 100% duty cycle? In that case, it'll behave like =
a gpio output.
> > > > > So when it's enabled, it does not use the prescaler.
> > > > > But! what happens if we now set that output to a different duty c=
ycle?
> > > > >=20
> > > > > Example:
> > > > > 1. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  per=
iod=3D1/200Hz)
> > > > > 2. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, per=
iod=3D1/400Hz)
> > > > >   fail? no, because it's not actually using the period (it's full=
 on)
> > > > > 3. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D100%, per=
iod=3D1/200Hz)
> > > > >   fail? no, because it's not actually using the period (it's full=
 on)
> > > > > 4. output 1: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%,  per=
iod=3D1/400Hz)
> > > > >   fail? no, because only output 1 is using the prescaler
> > > > > 5. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, peri=
od=3D1/400Hz)
> > > > >   fail? no, because output 2 is not changing the prescaler
> > > > > 6. output 2: set pwm mode (enabled=3Dtrue, duty_cycle=3D50%, peri=
od=3D1/200Hz)
> > > > >   fail? yes, because output 2 is changing prescaler and it's alre=
ady in use
> > > > >=20
> > > > > IMHO all this can get very complicated and tricky.
> > > >=20
> > > > Is this really that complicated?
> > >=20
> > > I think it is.
> >=20
> > Care to specify what exactly is complicated about it? You're just saying
> > that you don't like the restrictions that this implements, but there's
> > really nothing we can do about that because the hardware just doesn't
> > give you that flexibility.
>=20
> The complicated thing is to chose how to map the hardware imposed
> limitations to the consumers of the two (or more?) channels. And the
> problem is there is no golden way that is objectively better than all
> others.
>=20
> > > > I sounds to me like the only thing that you need is to have some so=
rt
> > > > of usage count for the prescaler. Whenever you want to use the
> > > > prescaler you check that usage count. If it is zero, then you can j=
ust
> > > > set it to whatever you need. If it isn't zero, that means somebody
> > > > else is already using it and you can't change it, which means you h=
ave
> > > > to check if you're trying to request the value that's already set. =
If
> > > > so, you can succeed, but otherwise you'll have to fail.
> > >=20
> > > With this abstraction Sven's questions are changed to:
> > >=20
> > > Does a PWM that runs at 0% or 100% use the prescaler?
> > >=20
> > > If yes, you limit the possibilities of the brother channels. And if n=
ot,
> > > it will not be possible to go to a 50% relative duty cycle while
> > > retaining the period. Both sounds not optimal.
> >=20
> > Again, this is a restriction imposed by the hardware design and there's
> > nothing in software that we can do about that. The only thing I proposed
> > was a simple way to detect the circumstances and make sure we can deal
> > with it.
>=20
> The point I want to make is, that with the usage counter you suggested
> you just shifted the problem and didn't solve it. I agree we need a
> usage counter, but you still have to think about how you want to answer
> the original questions by Sven. Depending on that you have to
> consider a channel running at 0% or 100% a user, or not.  (Or the other
> way round: You select a policy if you consider 0% and 100% a use and
> implicitly answer the questions with it.)

The way I see it, and I think this matches what was said earlier, we
have two options:

  1) Use two channels as proper PWMs. In that case, if they happen to
     run at the same period, they are free to choose the duty-cycle and
     can be treated as independent PWM channels. If the run at different
     periods, one of them can only be used as either full-on or full-off
     PWM. It would still be a PWM, but just with additional restrictions
     on the duty cycle.

  2) Use one channel as full PWM and the other channel as GPIO.

2) is a subset of 1) because we can implement 2) using 1) by treating
the full-on/full-off PWM as a GPIO pin. In my opinion, that makes the
first policy better because it is more flexible.

> > And that's obviously subject to the kind of policy we want to implement.
> > I don't think it's necessarily a bad thing to give people the most
> > flexibility. If they know that one PWM channel is only ever going to be
> > full-on/full-off, then they can still use that other channel in whatever
> > way they want. If, on the other hand, we assume that the prescaler is
> > always going to be used we limit the flexibility even if we don't
> > necessarily have to.
>=20
> I think we agree here, just with different words. The only thing I doubt
> is: You wrote: "If they know $X, then they can still use that other
> channel in whatever way they want." Who is "they"? How can they know
> that $X is valid for someone else, or anyone else? Or is it enough that
> "they" know this about their own use? Now Clemens wants to improve the
> driver, does he need to consider "them" in the mainline driver
> implementation? If Clemens chooses one way or the other, will there be
> someone who then will produce a use case contradicting the implemented
> policy? How will you (or who will then) decide which use-case is more
> important?

"They" refers to whoever writes the DT. Given the hardware restrictions,
the use-cases are already limited, so you are not going to get into a
situation where option 1) wouldn't work for any *supported* use-cases.
You can obviously always come up with a use-case where it wouldn't work,
but if that's not supported by the hardware, then obviously there's not
a thing we can do about it, as we already concluded.

However, if you know that your hardware is restricted in this way, then
the hardware designers will already have ensured that the supported use-
cases don't conflict with the hardware.

So if for example you want to support both a PWM fan and an LED with the
two outputs, then that's going to work because you can select a period
that works for both and run them both at the same period but at
different duty cycles.

If you have some other setup where one use-case requires the PWM period
to be adjustable, then by definition with this hardware the second
channel can't be required to be adjustable as well. In that case you can
not rely on the second channel to be anything but full-on/full-off. But
that's still enough to implement a basic LED, so that's what the board
might support.

Now you can obviously implement a simple LED using either a GPIO or a
PWM, so it doesn't really matter in that case which policy we choose
here. However, a GPIO is a special case of a PWM, so I think modelling
the second output as a full PWM is better policy because it gives you a
tiny bit more flexibility.

So what I'm saying is that the hardware already dictates the set of
possible use-cases, so if anyone is going to use this in a way that
isn't supported, then it's okay to fail.

> > Obviously if you want to use both channels at partial duty-cycles there
> > isn't much you can do and you really have to make sure they both run at
> > the same frequency/period. But that's usually something that you can
> > deal with by just choosing a period that works for both.
> >
> > And if that's not possible, well, then you better just use a different
> > PWM controller to begin with, because you just can't make it work.
>=20
> Yes.
>=20
> > > > > We can of course make this much simpler by assumung that gpio or =
on/off pwms
> > > > > are actually using the prescaler. But then we'd be limiting this =
chip's
> > > > > functionality.
> > > >=20
> > > > Yeah, this is obviously much simpler, but the cost is a bit high, i=
n my
> > > > opinion. I'm fine with this alternative if there aren't any use-cas=
es
> > > > where multiple outputs are actually used.
> > >=20
> > > This metric is wishy-washy; of course you can construct a use-case. I=
'd
> > > still go for this simpler option and assume the prescaler used if the
> > > PWM runs at 0% or 100%, but not when it is a GPIO.
> >=20
> > I don't understand what you're saying here. On one hand you seem to
> > object to what I was saying, but then you agree with it?
> >=20
> > And I'm not asking anyone to make up any artificial use-case. What I'm
> > saying is that if there aren't any existing use-cases that would break
> > if we assume a pre-scaler is used for full-on/full-off, then I'm okay
> > with making that assumption and simplifying the driver. If there were
> > use-cases, then that assumption would break existing users and that's
> > not something I'm willing to accept.
> >=20
> > Anything wrong with that metric in your opinion?
>=20
> The part I called wishy-washy is: "[....] if there aren't any use-cases
> where [...]". Who should decide what are (relevant) use-cases? We
> already agreed above that we talk about a hardware that doesn't allow us
> to consider it consisting of 2 independent channels and so we somehow
> have to limit their capabilities exposed by the PWM API. And whatever
> compromise we make, it's not hard to find a more or less realistic use
> case where the compromise hurts. So my interpretation of your words are:
> "I'm fine with this alternative if $somethingimpossible" which is not
> helpful.
>=20
> So yes, there is something wrong with your metric because it's IMHO
> impossible for a driver author to actually use it.

Like I said, that's not what I was saying. I was merely saying that if
there aren't any use-cases that current users rely on that would be
broken by using this simpler implementation, then I'm okay with it, even
if it's less flexible than a more complicated implementation. It should
be possible to determine what the current users are by inspecting device
trees present in the kernel. Anything outside the kernel isn't something
we need to consider, as usual.

Thierry

--1KsO48xkyUADVIL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SVpIACgkQ3SOs138+
s6EwaQ//TPX6JAAg+zCtg2CqWQRT5eT0FConvoIGKmqZp/neSGtTXvGxUFdGkAyy
XVbrhpacYjsZWiw/gjvsMaexdAaTtcX0J1mS63j3ZoS0KznTKvZ9M2sBpW4rfL5i
49zYLS52d1Z/fUOhaB44etABt4adVx9WhnvogeMWBUZhSqf2xI2Zops0kDPpXqQt
eYzGj9kPEX+xRbnpbwZAUpzzDVfl8XcBWc7O7hR1JZTP3wV09rh/GaZto2zTubSH
yDyjBJRSt/CKDI/56Qthsv6hD4oXAXIlEDBzX/NxMQbrD+CgV6Rliec0OkNINKdR
brkWJ4Ty7EQVRmUFudKcsWpGQVSHn5Dt9nJ3pVQoseKMJCPvMI8NrNU+MlmHpcA7
gme2kM3nFyE1st/4Pahs2H7IpckmIIW/yUnGRHYSMWb3FBiiSEzqR1pNu05jGSp7
fjulTUJaPOcvP3wTb4KVucT6d3cEZ63vqB7TQF89a1KkCh8DgmdBj3OrO52Qfprh
B1vgLdrwwfauGZVCh8LmtBr98Nz95RKmX9EqvUf93IIDM4hgUwgElZ+xIQX+6Tl9
2I8HFG/YEdSwOBjUSfGabLwoPwKWCMANsD5wTDI8niCXom4JUFQ1hGT4TihwcrSh
18gTkBRnym2tyg48APNE7x2bKeBK+mTwNxvWBnw+P5IoYtNnts8=
=tnaW
-----END PGP SIGNATURE-----

--1KsO48xkyUADVIL+--
