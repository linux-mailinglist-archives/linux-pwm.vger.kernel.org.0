Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07749276A38
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Sep 2020 09:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIXHNC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Sep 2020 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgIXHNB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Sep 2020 03:13:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E88C0613CE;
        Thu, 24 Sep 2020 00:13:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e17so2402464wme.0;
        Thu, 24 Sep 2020 00:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RRPcJ17lOHdPYl0Zs+IZ4S9cb28VG0LLD/X6tff755Y=;
        b=D6X2oniLTpkMYrIGpqBuwk8gi8bnbimqG3CHb7mSNmlX1p1TirZHDlPdt3VsudTLB2
         vWkfIY2WVg/cxtLwKwsydB6ZXo2PICfNNrtLijb/Lk8dI/AGWqi3ERejMC3ayOkkF8cz
         EdKqURZEiYc+a1x2Dm0TDbf7vPWwodDxnYYSX3H54k0q7fVH2jBY56WPP5tZ47sW0LKu
         2G3aEgg5sw7I+47e/XjpJnHbKVmCbSxp3OVFAe67c61hqqc5YLsGGKDjcxLq/E8CxZmk
         ssTzTHXONOKl9fQslFhrlv0QO3b9AYBfz0IEydkXauIMJt19yrfXRxV80ZZpG6ukjNdH
         AFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RRPcJ17lOHdPYl0Zs+IZ4S9cb28VG0LLD/X6tff755Y=;
        b=fEbxoitSuqA/Z/irV38XKgDbc/dHtBmnTRbv9Xm+WpGyLWR0t2762tCXtD9gO4LSxf
         QaPoZxPI5CjzTk+rzalihc6rrDpQHcxwjhvy9DYwLTsKbJWdIC/olDXlIcQiLqdkUiLw
         NBJWV4sgM2xy7QLXA2E+u1SVneTXYEVaRR0aErPeR9vidaDW1NBqH1pp0dt5Qw0E+XV7
         Qa+piOco+5EExZQ8mud1921WabSBWZ7UqVmKvlA41RDjPbuw0MaXNKkQMqFrp/rZK6Hq
         chsTZVNELM09hTldSMg2aCaHfutPFPHiWsuVcYi6sBjVvjfwS9cj82fak5qbQkeFxn6q
         AL0w==
X-Gm-Message-State: AOAM532m3/uFPmVNq9tBlgE6vwBhYx5zwF8pAsdRXBkLTgWwG/j21TOR
        vRzukGkTDRO11M/G4Gnxy4A=
X-Google-Smtp-Source: ABdhPJzQf7nn95RZvhNQ4P4HpXHncMBWKoSmvvl7mPfut7atd3yjp9inVDQCbXvRjoeszq636E7rcw==
X-Received: by 2002:a1c:e3c3:: with SMTP id a186mr3356207wmh.189.1600931579711;
        Thu, 24 Sep 2020 00:12:59 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id l8sm2436390wrx.22.2020.09.24.00.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:12:58 -0700 (PDT)
Date:   Thu, 24 Sep 2020 09:12:56 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-pwm@vger.kernel.org, lee.jones@linaro.org,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v13 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200924071256.GA2480300@ulmo>
References: <cover.1600158087.git.rahul.tanwar@linux.intel.com>
 <befa655d8beb326fc8aa405a25a8b3e62b7e6a4a.1600158087.git.rahul.tanwar@linux.intel.com>
 <20200924065534.e2anwghhtysv63e7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20200924065534.e2anwghhtysv63e7@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:55:34AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> (hhm Thierry already announced to have taken this patch, so my review is
> late.)

There's also a build warning in linux-next caused by this patch, so I'm
going to back it out.

Rahul, please address Uwe's comments and make sure to fix the build
warning as well.

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sRvUACgkQ3SOs138+
s6FWAw/8DWVIkoalBKXRaRmRZ9AQND11fZmXmkow23zqPqOXA26Tb14A2SBbxcEs
VfCSn6iHSBvjpVVLuvZnIZ9v4rYwXPewtMVVg5eiCA/H83TnDFXNTsKkG+M7FIor
f1Eq6ueZoHXG/iNHtBkgCCZp/vw7lmhevMZHPWeuIJ24Hs2xfreLOS2ZEd41jOkO
/jiYWvksxAOCCp7vmoo+9FggWGVUuUxA86hde8D9WmMYbuBqEjV5TXYxHNDn+MRT
Vb5/0uu6MVUl1TS1/3Y87p0ENg3lBa9UdI3zrkdrsv3+ToK0qckKvNiZGasA4+O2
HtyhapjI/WJT1EylIOHToTyXAgggsrZ7LNyWEFVbNED1vnXYoeEbE41IxszCrMRR
xcP9Bb9R3dMAv49m52/Ipl0ZTzx1QeTE+Xtq1MOwrYXfQ8HJE0EQkaIqF7iuD/ND
dSs+sAnll/lGBsw69oDMlLzYJv5GninITkVsoMnbMwMvvHUQfmLiSZXmBCoag/Ff
MwvFuLAQGJQil9YM6hhXJfzkisnOjSVCSuLvm+fvycWt3gPwmauDLzopNJWyyXcg
1SvkrDrj22Urzvb9Jydxi2+IhX8iKWAT19u47wUpCJEfd8VQ7cjnd/CHBW/egPmy
eCLk/9UZLj9XByGc+Kq8kjYHsP5vwWdY9sRtOlnPrl6IbRUgWiQ=
=xW5c
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
