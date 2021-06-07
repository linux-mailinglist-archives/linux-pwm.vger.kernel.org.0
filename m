Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90A39DEF3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFGOl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 10:41:27 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:39685 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 10:41:27 -0400
Received: by mail-wr1-f46.google.com with SMTP id l2so17938628wrw.6;
        Mon, 07 Jun 2021 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQEKxKVEnKLJRyGaUv0SeKM1LMIxcVRtYk8SISspw4E=;
        b=ZIh2+8zsD/IhcNEuk2F31p8Es/525XfUKhUYnpfHNxvx7Hw+XUGbymDrB5i9UZoZK7
         YvppZjwgK4Nq3oQ/L/8oV8K/eBtfUOTuLuCpLvpwipSy0bo0XhtuRqgheOZMoP4RQ1yw
         zhFNYSgCeH+k1bmKyn7zrFxAoPI7Zd8r3+HPX3Wz6eTuQh1LtT0qOZUFYMN/CRYag1er
         /O3dQoOHds/NSopU5qRwF336Vt/Elf4EZBcSclTyj1hsoDc6gb8KWu7lkl/6RAB2IalJ
         H+BwT8+hbn++WjIYslVmSbTs7yQ6aPPtLjlDw5MA24yZLO97xshdlrWmzIVwHzDKtiOv
         HObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQEKxKVEnKLJRyGaUv0SeKM1LMIxcVRtYk8SISspw4E=;
        b=GV3wmUzjL0xHLYcnaT8xzwS1mU0+ROwYzo57W/93rtsSAlxpqLG0iMqJQNYqK40X7A
         a6RDcvdtD9WQkZWYllU6Vo2PBg4sxgudpZg07cft5SFIktovxHvKssPto70FiGpNQO9k
         ZcMzXnPhjTs1E3Pz0/zJdtSlwlQuvPe4rln6uIKSKzOVLxlIcrBsHtBFDX6UYydkSoT1
         UI6yVJysDF/HZABPooHiRUA985ea78TENcfEZx1kcg1rDPwdIOMdGs/2JC9urShIZXZe
         H3E6YNV2GMxXHMK6+In1zSMNU+/lDGD/ZNbR+MqdJT55oZLZZPmRvd5kLJeppbA5rcsU
         HK8g==
X-Gm-Message-State: AOAM532LRtROvNDtjsyvbiSs5B8jMjK9ajLo3EWOax9wPfL9q+tSXFvj
        EMzNEo6nhq6eB+khfoTI9mA=
X-Google-Smtp-Source: ABdhPJyX9TmI/pwv5vpMST2BM1phzyIaw9dPFg7f4S3SLahnSrWgJp+Jjs5QSMc0+zbDpSroteJ9uw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr17656684wrt.209.1623076714914;
        Mon, 07 Jun 2021 07:38:34 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id z11sm15543052wrs.7.2021.06.07.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:38:33 -0700 (PDT)
Date:   Mon, 7 Jun 2021 16:40:14 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <YL4vzvznTzqih0pA@orome.fritz.box>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwy1/Qax+gOdkBIj"
Content-Disposition: inline
In-Reply-To: <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xwy1/Qax+gOdkBIj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 07, 2021 at 08:08:27AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Thierry,
>=20
> On Fri, Jun 04, 2021 at 11:49:37AM +0200, Thierry Reding wrote:
> > In the interest of making forward progress, I've applied this series.
>=20
> I proposed a different approach that in contrast to usage_power:
>=20
>  - is well defined
>    (so driver authors and consumers know what to provide or expect resp.);
>  - has good name people understand without reading documentation;
>  - fully covers the problem Clemens want to address;
>  - fully covers what the only implementing lowlevel driver does; and
>  - is easy to implement based on the patches in this series
>=20
> This is not what I call "forward progress". I take it personal that
> after I pointed out technical shortcomings with this patch set and even
> suggested a better concept, you didn't even made the effort to argue
> but instead simply went on applying the patches.

Forward progress doesn't always mean that everybody gets their way. And
this is nothing personal, so please don't take it that way.

I don't see where you pointed out technical shortcomings with this
patch, you merely pointed out that you don't like this solution and that
there might be a better way to implement it by expanding on the concepts
introduced in this patch series.

As I said, this is now no longer impacting ABI, so we can improve on
this further down the road if we choose to. However, I didn't see any
reason to postpone this any further. This is something that Clemens has
been working on for more than half a year and we've changed our minds
often enough. In my opinion this proposal is good enough.

Thierry

--xwy1/Qax+gOdkBIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC+L8sACgkQ3SOs138+
s6G4Zw//XUROGNoS170lWAxGbjxoOOBKdHW85K465igvZNayXMRl7jtqecHshOs2
xARMj0OspgqWA66ZBWqEHvG9V8FYu6fhPeBlkOLs+vppSZPiK4o8dWgSLKNp61W8
Yy631s36LmbqxVwkvJyQrzZKhdP6pMDSIlQRT0891GEH28HekbQ/XXL8morgV0zu
BtM9wuTxfi7+n6VfeYysFpkbqXvIQGoq1SJ5fLcfK6AjCgv3sV4iQB1mZDaL6clP
mU1U4wQ1tOICA6zxzrYyM4kbeReqIwHaBPFx3+JV29W2oSdbZec+RjID+E4KQD5A
Qpg6tFcVYf+YDafEZ1WpxAAPjv1PZj7GfctKIOAxUMKEumQAydMAa1eBru5hEWaL
AADmHjWt1nywM4RovmruE0WutBLswPVYSPHUvxPAbEaZlLYeyYo8s2D0BsmL18Ps
H7Ny7j5tJGa1xtbqZ4kOCiGQkNpoYX9u06HJBrs5un0NWs+2vhTpjw2rrUTmZeVy
mLgsvqn9He15kngJkLw/rkQTZaqAYa5qgoO1CjnkVGzibwr5NTtZ1Uc/UG7f2KsF
ZKaOuCGQ1NOWg1Ca5hfAxaCsBITtXP4e8PY/twGuZcBDOJAXvuufW+qUp1vWF4j3
yaxLjVjglBP8QIOCIPF1uBc6lL0I2lGcQupSGJY6lsKFWr3Sank=
=NYrY
-----END PGP SIGNATURE-----

--xwy1/Qax+gOdkBIj--
