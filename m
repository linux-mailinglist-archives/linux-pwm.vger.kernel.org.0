Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDAD271E40
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Sep 2020 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIUIoG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Sep 2020 04:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUIoG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Sep 2020 04:44:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C423C061755
        for <linux-pwm@vger.kernel.org>; Mon, 21 Sep 2020 01:44:04 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHQY-0003L9-Oz; Mon, 21 Sep 2020 10:44:02 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kKHQY-0008VF-42; Mon, 21 Sep 2020 10:44:02 +0200
Date:   Mon, 21 Sep 2020 10:44:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     vijayakannan.ayyathurai@intel.com
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v7 2/2] dt-bindings: pwm: keembay: Add bindings for Intel
 Keem Bay PWM
Message-ID: <20200921084401.gtesjzentxrly47c@pengutronix.de>
References: <20200909162719.7585-1-vijayakannan.ayyathurai@intel.com>
 <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjn32z62txufjijw"
Content-Disposition: inline
In-Reply-To: <20200909162719.7585-3-vijayakannan.ayyathurai@intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wjn32z62txufjijw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 12:27:19AM +0800, vijayakannan.ayyathurai@intel.com=
 wrote:
> From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
>=20
> Add PWM Device Tree bindings documentation for the Intel Keem Bay SoC.
>=20
> Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.co=
m>
> Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

nitpick: Your S-o-b should always be last. This way it becomes clear who
added the other tags.

(No need to resend for this, but as patch 1 need some love, please fix
this, too.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wjn32z62txufjijw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9oZ88ACgkQwfwUeK3K
7AmudQf/ZcTyam1Ds0BugxbM3DLfrwTSM9BHx3OAv/QQmJ9/fm1amCZ8Nh71fVMd
lXZIBU0QoGDaWSoNMHenJTPXyzgFFuTd6WmqripNdrXuaC3efdJg0ttZc6YvCQWF
oy0YVV6aQUiD4ux4UnTLi57f5pQFNva833ShmI1VB/MSd6FdY86ibTvlq5s0m4fY
ld6KHtcNTGc8OxdNXpodJd8YIf3lCJgVFwaSUIL2pcIN8jscd+kq4vLL7P4VK0NH
TYs7n/Q884kYtvPOE0+V3N46bcDK4b/BGFqddukM3RMp/fzuzLCB1C9k2CA/ONyk
Lt12s8KjcYTTQt6M4Nh0d/iCbxX3YQ==
=f0mk
-----END PGP SIGNATURE-----

--wjn32z62txufjijw--
