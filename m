Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B617D5915
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJXQqj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjJXQqh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 12:46:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C2610D0
        for <linux-pwm@vger.kernel.org>; Tue, 24 Oct 2023 09:46:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvKY1-0007FE-Qn; Tue, 24 Oct 2023 18:46:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvKXz-003zGY-V7; Tue, 24 Oct 2023 18:46:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvKXz-005MZn-LY; Tue, 24 Oct 2023 18:46:27 +0200
Date:   Tue, 24 Oct 2023 18:46:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: samsung: Document new member .channel in struct
 samsung_pwm_chip
Message-ID: <20231024164627.ejcqrtbhvohduvpg@pengutronix.de>
References: <20231012210228.1009473-2-u.kleine-koenig@pengutronix.de>
 <169720375693.285367.8034783567173304872.b4-ty@gmail.com>
 <20231013172750.nxcw2ftihpemnymx@pengutronix.de>
 <20231024145524.7qkzrrdm6zg5hfji@pengutronix.de>
 <fa624966-176a-47d1-937d-8384fda06513@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m2c65dln5efzqyy5"
Content-Disposition: inline
In-Reply-To: <fa624966-176a-47d1-937d-8384fda06513@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--m2c65dln5efzqyy5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 04:58:22PM +0200, Krzysztof Kozlowski wrote:
> On 24/10/2023 16:55, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Fri, Oct 13, 2023 at 07:27:50PM +0200, Uwe Kleine-K=F6nig wrote:
> >> On Fri, Oct 13, 2023 at 03:29:35PM +0200, Thierry Reding wrote:
> >>> On Thu, 12 Oct 2023 23:02:29 +0200, Uwe Kleine-K=F6nig wrote:
> >>>> Fixes: 4c9548d24c0d ("pwm: samsung: Put per-channel data into driver=
 data")
> >>>
> >>> Applied, thanks!
> >>>
> >>> [1/1] pwm: samsung: Document new member .channel in struct samsung_pw=
m_chip
> >>>       commit: 4bb36d126cb3147d6bbfd00242a5b846dacad595
> >>
> >> You might want to change 4c9548d24c0d to e3fe982b2e4e now that you
> >> rewrote your for-next branch.
> >=20
> > This is still open. I wonder there is no automated check that warns if
> > there is a Fixes: line in next that doesn't refer to an ancestor.
>=20
> I am using Greg's/Stephen's scripts in commit hooks:
> https://github.com/krzk/tools/blob/master/linux/git-hooks-post-commit
> https://github.com/krzk/tools/blob/master/linux/verify_fixes.sh

Skimming throud the verify_fixes script I'd say the following addition
to verify_fixes should do:

diff --git a/linux/verify_fixes.sh b/linux/verify_fixes.sh
index f22384bb6bb8..12e73da82dd4 100755
--- a/linux/verify_fixes.sh
+++ b/linux/verify_fixes.sh
@@ -100,6 +100,13 @@ verify_fixes()
 				continue
 			fi
=20
+			if ! git merge-base --is-ancestor "$sha" "$c"; then
+				printf '%s%s\t\t- %s\n' "$commit_msg" "$fixes_msg" 'Target SHA should =
be an ancestor of your tree'
+				commit_msg=3D''
+				error=3D1
+				continue
+			fi
+
 			if [ "${#sha}" -lt 12 ]; then
 				msg=3D"${msg:+${msg}${nl}}${tab}${tab}- SHA1 should be at least 12 dig=
its long${nl}${tab}${tab}  Can be fixed by setting core.abbrev to 12 (or mo=
re) or (for git v2.11${nl}${tab}${tab}  or later) just making sure it is no=
t set (or set to \"auto\")."
 			fi

It has quite a few hits in next ...

> Happy to receive more ideas during:
> https://lpc.events/event/17/contributions/1498/

I hope you pick up this idea even without me repeating this suggestion
there :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m2c65dln5efzqyy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU39OIACgkQj4D7WH0S
/k5QuQgAmzqLO/0dc4cd4N23U8MJeIxIAYDv3VemvD8coDZP26exOMzourZetsUk
yt80W9oFkrQITq9NN5YDDqFptCzOcvTS1TuefKcwbWCzre6d/+kJ3MQ26POiwNfL
TZ+kS0L9oCDHkdXB0H19Uzm6YgpgojlLKhrvW5+kjPfWcBsq/63ywwoDhBxLgYar
akSsGPkSCsgRnfdHP2bfTP3dVLRmkcbrkOKlw2LQjTNXF363WxVJ8yKiXaZtfLgz
B6O6XGfH2eFhhBfBS0kUgqdt6lIyvIWyvh5Jpw5ZMKqJjDohpDxdb29232afLh68
gndmcLpko2rwC9qH+vRdG+G+Gs8F0Q==
=Tptg
-----END PGP SIGNATURE-----

--m2c65dln5efzqyy5--
