Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56C92B0F28
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 21:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgKLUoD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 15:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKLUoD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Nov 2020 15:44:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD35C0613D1;
        Thu, 12 Nov 2020 12:44:02 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c17so7395324wrc.11;
        Thu, 12 Nov 2020 12:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q+20iQAaEm4q/hEUaeWqM8BE9cNbPFG1XCmKyaVmb68=;
        b=HxwjxsQm/Aehke3Fv5Qn1I/gx7cdcRVWHLoh7zMN5d6eja8wHhSwqI6sNuOlWiDgNH
         0Yk86Dq0DkpNIvkBJ+FwawM++mZMAehPqdID+EWV27o8WwtUqxDUvInTFbiypDsJgwPO
         bpmLU7bpYlrsuR+o9ZncT+A0IlgSbNVB7rOK86hVP8U4ezJN17KnYlu/slvBwZGjh9fD
         OL9JGA3ZycVyXsWPE2zA+B7OjU+hXZxmZzWQOIcJLqf2hJ/js89Z7Qpa4wcNaVgbYqdj
         1ME8LenkMJPlcTOvmGNzF4CxAdmiZJcOq12brSvwJezr+w4EP3VwLwyA2o6RZM1xn67d
         Jb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q+20iQAaEm4q/hEUaeWqM8BE9cNbPFG1XCmKyaVmb68=;
        b=nn3bERIaX/fYr8Nf43y88fDI3j0Fu+d4Hs9ZVofl057mf9kNXdwRo8Sx7wofhJNWf5
         Q9QlMIwtqNBOpB9aDgRxYvVChrkird3taRe80zHQzabjFFhI1ZIKrBWVfXe5jlV2Okp3
         CE2i94MyHadEsko34g94kY0j2g9cyE0WvlxYpgwFiO1F2AgS27tIn77XXrXIqrFbugbs
         FIZN+3Iz3+PWwQH7U945hwVf9MUG+102ht6ih7nCltJqsU8kH1izFm20liy1Ygl26wXO
         n0kkSqyal1qOwXfmG7rs7txdL4zr7dAD+lhlNW2UNT+cYsEhRDvs84B9ByyCAjwJwnMw
         fkxA==
X-Gm-Message-State: AOAM531c34IRYeXCJ/zUzre9pC20jpnijgatgPdVyhJvpvu+t8yyLhN/
        2M1ZHeTE2fGYhfCJ0rLdxno=
X-Google-Smtp-Source: ABdhPJxE9+HQyG91KkMLLlz6E63XshyQv4iVzGZmBh44qaFqvMY2XiAJIXziTAWHEenvefZ/TDIvrg==
X-Received: by 2002:adf:b109:: with SMTP id l9mr1479729wra.279.1605213841288;
        Thu, 12 Nov 2020 12:44:01 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t11sm1498448wrm.8.2020.11.12.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:43:59 -0800 (PST)
Date:   Thu, 12 Nov 2020 21:43:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v1 00/30] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201112204358.GA1027187@ulmo>
References: <20201104234427.26477-1-digetx@gmail.com>
 <CAPDyKFr7qTU2RPhA_ZrbCayoTTNUEno1zdmvmv+8HBe-Owrfeg@mail.gmail.com>
 <cd147ab0-1304-a491-7a56-ee6199c02d32@gmail.com>
 <2716c195-083a-112f-f1e5-2f6b7152a4b5@gmail.com>
 <CAPDyKFqUMsH9dCZ=OYqfdLt==+-8NjK9n=S5jGGNXZu6Y9q=2w@mail.gmail.com>
 <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <1f7e90c4-6134-2e2b-4869-5afbda18ead3@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2020 at 10:57:27PM +0300, Dmitry Osipenko wrote:
> 11.11.2020 14:38, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, 8 Nov 2020 at 13:19, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 05.11.2020 18:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> 05.11.2020 12:45, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> ...
> >>>> I need some more time to review this, but just a quick check found a
> >>>> few potential issues...
> >>>
> >>> Thank you for starting the review! I'm pretty sure it will take a cou=
ple
> >>> revisions until all the questions will be resolved :)
> >>>
> >>>> The "core-supply", that you specify as a regulator for each
> >>>> controller's device node, is not the way we describe power domains.
> >>>> Instead, it seems like you should register a power-domain provider
> >>>> (with the help of genpd) and implement the ->set_performance_state()
> >>>> callback for it. Each device node should then be hooked up to this
> >>>> power-domain, rather than to a "core-supply". For DT bindings, please
> >>>> have a look at Documentation/devicetree/bindings/power/power-domain.=
yaml
> >>>> and Documentation/devicetree/bindings/power/power_domain.txt.
> >>>>
> >>>> In regards to the "sync state" problem (preventing to change
> >>>> performance states until all consumers have been attached), this can
> >>>> then be managed by the genpd provider driver instead.
> >>>
> >>> I'll need to take a closer look at GENPD, thank you for the suggestio=
n.
> >>>
> >>> Sounds like a software GENPD driver which manages clocks and voltages
> >>> could be a good idea, but it also could be an unnecessary
> >>> over-engineering. Let's see..
> >>>
> >>
> >> Hello Ulf and all,
> >>
> >> I took a detailed look at the GENPD and tried to implement it. Here is
> >> what was found:
> >>
> >> 1. GENPD framework doesn't aggregate performance requests from the
> >> attached devices. This means that if deviceA requests performance state
> >> 10 and then deviceB requests state 3, then framework will set domain's
> >> state to 3 instead of 10.
> >>
> >> https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/d=
omain.c#L376
> >=20
> > As Viresh also stated, genpd does aggregate the votes. It even
> > performs aggregation hierarchy (a genpd is allowed to have parent(s)
> > to model a topology).
>=20
> Yes, I already found and fixed the bug which confused me previously and
> it's working well now.
>=20
> >> 2. GENPD framework has a sync() callback in the genpd.domain structure,
> >> but this callback isn't allowed to be used by the GENPD implementation.
> >> The GENPD framework always overrides that callback for its own needs.
> >> Hence GENPD doesn't allow to solve the bootstrapping
> >> state-synchronization problem in a nice way.
> >>
> >> https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/base/power/d=
omain.c#L2606
> >=20
> > That ->sync() callback isn't the callback you are looking for, it's a
> > PM domain specific callback - and has other purposes.
> >=20
> > To solve the problem you refer to, your genpd provider driver (a
> > platform driver) should assign its ->sync_state() callback. The
> > ->sync_state() callback will be invoked, when all consumer devices
> > have been attached (and probed) to their corresponding provider.
> >=20
> > You may have a look at drivers/cpuidle/cpuidle-psci-domain.c, to see
> > an example of how this works. If there is anything unclear, just tell
> > me and I will try to help.
>=20
> Indeed, thank you for the clarification. This variant works well.
>=20
> >> 3. Tegra doesn't have a dedicated hardware power-controller for the co=
re
> >> domain, instead there is only an external voltage regulator. Hence we
> >> will need to create a phony device-tree node for the virtual power
> >> domain, which is probably a wrong thing to do.
> >=20
> > No, this is absolutely the correct thing to do.
> >=20
> > This isn't a virtual power domain, it's a real power domain. You only
> > happen to model the control of it as a regulator, as it fits nicely
> > with that for *this* SoC. Don't get me wrong, that's fine as long as
> > the supply is specified only in the power-domain provider node.
> >=20
> > On another SoC, you might have a different FW interface for the power
> > domain provider that doesn't fit well with the regulator. When that
> > happens, all you need to do is to implement a new power domain
> > provider and potentially re-define the power domain topology. More
> > importantly, you don't need to re-invent yet another slew of device
> > specific bindings - for each SoC.
> >=20
> >>
> >> =3D=3D=3D
> >>
> >> Perhaps it should be possible to create some hacks to work around
> >> bullets 2 and 3 in order to achieve what we need for DVFS on Tegra, but
> >> bullet 1 isn't solvable without changing how the GENPD core works.
> >>
> >> Altogether, the GENPD in its current form is a wrong abstraction for a
> >> system-wide DVFS in a case where multiple devices share power domain a=
nd
> >> this domain is a voltage regulator. The regulator framework is the
> >> correct abstraction in this case for today.
> >=20
> > Well, I admit it's a bit complex. But it solves the problem in a
> > nicely abstracted way that should work for everybody, at least in my
> > opinion.
>=20
> The OPP framework supports both voltage regulator and power domain,
> hiding the implementation details from drivers. This means that OPP API
> usage will be the same regardless of what approach (regulator or power
> domain) is used for a particular SoC.
>=20
> > Although, let's not exclude that there are pieces missing in genpd or
> > the opp layer, as this DVFS feature is rather new - but then we should
> > just extend/fix it.
>=20
> Will be nice to have a per-device GENPD performance stats.
>=20
> Thierry, could you please let me know what do you think about replacing
> regulator with the power domain? Do you think it's a worthwhile change?
>=20
> The difference in comparison to using voltage regulator directly is
> minimal, basically the core-supply phandle is replaced is replaced with
> a power-domain phandle in a device tree.

These new power-domain handles would have to be added to devices that
potentially already have a power-domain handle, right? Isn't that going
to cause issues? I vaguely recall that we already have multiple power
domains for the XUSB controller and we have to jump through extra hoops
to make that work.

> The only thing which makes me feel a bit uncomfortable is that there is
> no real hardware node for the power domain node in a device-tree.

Could we anchor the new power domain at the PMC for example? That would
allow us to avoid the "virtual" node. On the other hand, if we were to
use a regulator, we'd be adding a node for that, right? So isn't this
effectively going to be the same node if we use a power domain? Both
software constructs are using the same voltage regulator, so they should
be able to be described by the same device tree node, shouldn't they?

Thierry

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+tnowACgkQ3SOs138+
s6GpRw//bBN1XxoinOezBRqhMIwuf0sQcMTik6JsV5TIwuTEmBN0jBur2rTXJ40P
jKUu2leRszn9pkj693yplujBHu0Wreo6quD/n/AupD1JmaO8NfUlUzxpw/thwbCZ
saonMKedQEVVGg4pYK90NenOJVMOb1cNuf907K4e+CjP1GZkxph9+ogJqFbUBoFh
0TNxTZu/eQm5jU+8KYYAXxMkbTvZIj/7G9KagAh0dpsxG9KkfQoU1ATU1z+10w2U
uedMFgUOVlH8k2Y5AHgAYbGusCotyOlMjvhYqyaGIpjaBYJkFBwlpie+pkhRvQ/8
1QnLipuSmJlmjAzyReR+4zoyqES/e6WxIcIDhAVxhL+ptJLfd14m/B+Nk5PFbH2J
wm+8pbGMYLK7n0YF2AaoR6Yzy5HkxlHyZcSDL4f62Va/XA56CZi7cons6UwU3Wn4
aXVDHbq+d4xSXMT1eFgnYVINdR43ebiFclmSci4XnAYsKnmoYMppu9Z4k3YsdPdI
hgOLYLPhtVcw2eJaIYDlWkS7HaKy5JFWfUdbqeB2Roasy4WHsjsUma8anAUZ5LWu
9b5I47tMigGN37KAcFuTqQ1Erkag4sL++dt99j7m9a48JkTRRiE4QOXJbWR5tB7P
p3pxybKsCYJuj+oX6QJYZPHYd4lzzz2z2skae4k/fSPXo9bsAS0=
=8L5E
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
