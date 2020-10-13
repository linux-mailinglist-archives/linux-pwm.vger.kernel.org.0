Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098CB28CA4C
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390992AbgJMIcM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390846AbgJMIcL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:32:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CF5C0613D0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 01:32:11 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFj7-0003lc-Ix; Tue, 13 Oct 2020 10:32:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFj5-0005M4-Pc; Tue, 13 Oct 2020 10:32:07 +0200
Date:   Tue, 13 Oct 2020 10:32:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201013083207.kgtvb4zzjuhfz7vj@pengutronix.de>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <a8cb129092283cb6415e56b928293ef7121a851b.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <20201007205734.vguookvp6wt3knuq@pengutronix.de>
 <DM6PR11MB42507C555C3F183ED6EB98ADFB070@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201012210112.tdca3so6dzplootw@pengutronix.de>
 <DM6PR11MB42507506D412B7D7D29DB01CFB040@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ao6ub7jcaasvd4dc"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42507506D412B7D7D29DB01CFB040@DM6PR11MB4250.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ao6ub7jcaasvd4dc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ayyathurai,

can you please fix your mailer to quote properly?

On Tue, Oct 13, 2020 at 02:54:31AM +0000, Ayyathurai, Vijayakannan wrote:
> Thank you for this clarification and I am clear in incorporating it in
> my next version. Is there any other feedback in this version v10?

I won't promise that I will not spot something in your v11, but
currently I told you about all issues I saw with v10.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ao6ub7jcaasvd4dc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+FZgQACgkQwfwUeK3K
7AkXyQf7BKFzUH4vuacoKoUaCa0oYK15w1poje8FRzLJo5JJRfFkWeEcuY9QQZjZ
zrfjpKDQ1VseR9PHxUBZW2DEPnhG0/wJFFxGLS+DukLLhawlR7JnAXZVx1yIByxY
V+UQMrM2BpukpD2GCL/v6E8ZYZbNS+l6nwDFCnjaVUuVtyKvikjP/QxkCUktUsr+
JMCDKbIOFiJmfOgskUrCrvTCjNCZz5wQ1Uv50ZbKx3MFZoviaCV0lSaka/q/pSv+
dyfmIKQ5BGBmzrWfXMzB9ndn/ZwVvTKGgtfD7VbOF6EdYFhYVbsnFz/vqzaUAo/x
eRpnk5azaOvsK67lfZZId2C9rikSuw==
=JC0j
-----END PGP SIGNATURE-----

--ao6ub7jcaasvd4dc--
