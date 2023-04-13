Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163236E0A53
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjDMJev (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 05:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDMJet (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 05:34:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EB5FD4
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:34:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso9619019wmb.1
        for <linux-pwm@vger.kernel.org>; Thu, 13 Apr 2023 02:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681378486; x=1683970486;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usrsMeWIttyJw0owmmQWzVqrIgZn4Z22vxHBzRtOZuM=;
        b=hN7wELFPGqMC67SSGq67J+Jej6Wh9rNZopAYaDztigd79JobRTjv5v40/Enes87ARb
         OXw6CSE2JHi3KZ2ndhRh6jvtJUMlkwRjItRmHoK9UhVXjmofobol6y9DU6TDBtF/HkwN
         rXxn/IWsfkUjYyeTFQUZbVSeGY5EpFPW75dLnDcIRzI2L4yHAT0r9SZDwSpmcpgS0XdB
         /fARtX3CLoirH+/NblmYcvIofeXtoUZSjNIDVsaUHiZzhfO6GU4NXtKnFzvKhjnRx70J
         bWznxnhALbrLK8Sar+WoV1ASAVcbID7ekT5evWNtT4XVzu7fPhgL2TTUUD6K/fWSqulk
         /KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681378486; x=1683970486;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usrsMeWIttyJw0owmmQWzVqrIgZn4Z22vxHBzRtOZuM=;
        b=IrB5HiF4E8a9TCV+eGUPiUxTk9qnioXxO2iBGlV78rEsCugsr6SyT0zDnmIJIaFu4n
         Y1nXLdxGVHXCGA/rG4Rr/5V75ULK7lgLtJ75rclHY3iSlagsugmJ5jfsNlsnkXzL2+kM
         GJYhL3Bif1Qb7Kyvq703oRl6hVEYrxV5kv7lEpx0VHJFSxekAW/JzgSPXGZMlYoq6gfI
         uuyZZWsFTKITZLh9QWgHcBoHwpbsrSGqtQRHt4dvFDVpa2zuBTT36djwZ6IsQw+712vQ
         GahkhBO7plEkFlKrRR2MUmppxMmJwR8K9RIq+8jhYcbusC2pN6l7SUHQAAXZD84I4x2R
         IxCA==
X-Gm-Message-State: AAQBX9coTQjaECy0neIi2ZOQ7dhAi+oeiylUwysabdtFMmt3QLASebF+
        c2oM5SnLD1a8OQEyFvljHFnGTMPzuC4=
X-Google-Smtp-Source: AKy350YDlbyGkYFbxbbV02IQa+uMeuhOw/ESZG4ozJ9TjG0DIOv8SP3MI6CrewWJFgDorlQb/RE2Gw==
X-Received: by 2002:a05:600c:2051:b0:3ed:8780:f27b with SMTP id p17-20020a05600c205100b003ed8780f27bmr1406391wmg.16.1681378486282;
        Thu, 13 Apr 2023 02:34:46 -0700 (PDT)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s6-20020a7bc386000000b003ef5db16176sm1313912wmj.32.2023.04.13.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 02:34:45 -0700 (PDT)
Date:   Thu, 13 Apr 2023 11:34:44 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Delete deprecated functions pwm_request() and
 pwm_free()
Message-ID: <ZDfMtB_lakGPDsZZ@orome>
References: <20230412115636.3533366-1-u.kleine-koenig@pengutronix.de>
 <ZDfLyP5bP0PdBS1J@orome>
 <ZDfMF3wAfbd-1y-Z@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SDNTOpHrXwnzty7i"
Content-Disposition: inline
In-Reply-To: <ZDfMF3wAfbd-1y-Z@orome>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--SDNTOpHrXwnzty7i
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:32:07AM +0200, Thierry Reding wrote:
> On Thu, Apr 13, 2023 at 11:30:48AM +0200, Thierry Reding wrote:
> > On Wed, Apr 12, 2023 at 01:56:36PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Since commit 5a7fbe452ad9 ("backlight: pwm_bl: Drop support for legac=
y PWM
> > > probing") the last user of pwm_request() and pwm_free() is gone. So r=
emove
> > > these functions that were deprecated over 10 years ago in commit
> > > 8138d2ddbcca ("pwm: Add table-based lookup for static mappings").
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  Documentation/driver-api/pwm.rst | 13 ++++-----
> > >  drivers/pwm/core.c               | 49 ------------------------------=
--
> > >  include/linux/pwm.h              | 13 ---------
> > >  3 files changed, 5 insertions(+), 70 deletions(-)
> >=20
> > There seem to be two more occurrences of pwm_free() in
> > drivers/pwm/core.c, but I think they can trivially be replaced by
> > pwm_put(). I can do that while applying, but let me know if you don't
> > agree.
>=20
> I also get warnings about pwm_to_device() now being unused, so I'll
> remove that one along with these.

With pwm_to_device() gone, there's now also no purpose in the pwm_tree
radix tree, so let me try to drop that as well.

Thierry

--SDNTOpHrXwnzty7i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQ3zLQACgkQ3SOs138+
s6H6vg/9GQ1o1cxQAWdm74cJ68g/D+v34WeYQiDxHHmfbqyjO90PJq7x1KswiAWm
CCtoWolMqJC3+WCj5J1xbK8bCBUsP4cRQrP1DsRzvF8jVik8QD1wf0W7eVgQqIP2
0nBUKVLuqBtFDGAcS3dCcb30Whi6mLu0JhOtMz2CaC+ZQk56oUBZM+bjJyOA4+1C
hxve6XK552toalkQ56oJcXk55jE6mvTlf2R4B8EED2Oho6FzxcGUvEiXmOrWLyEZ
I/EFGr5mn7j2xdux+SC5Zf8bNg1PJCtCt6ADRW+wMopDxUDqZyqtQgPcZOF6hqa5
G5eK6ds8YYhSRRWd3Db9/1bkPQ7kj4nPj0PCTUGwaUP/GZ8WdZ8jOK4j5rGC9w26
ex1Wyswu/GCZVoeyrhs5ZHKey78pKlNtwpDL5r7oJpdoeJisp1xQDXs3MdG3mrGp
mbU8i3kUQ3mRUeGOad5dMdziWZ2jzHfPlD8lN1HNfl0FyEvmgjn0kIxgtbQkJp/2
LwjohoBL371of7+hmsh+7rnemGofQ/ZwleeWC9AEgGWfG3sn98W5w5ZP3UnrDSEU
4tnkTQn8H4gH4aHT9J4Yb/CRWKeSNhdeqW376gNmCuB3rI1fV0OogpiYSMziJXo/
Mia8f6HVLkAiH1V21U0MeqyUZUK9A/OKjDHGLhca7sWyJxBm0Ww=
=zqXn
-----END PGP SIGNATURE-----

--SDNTOpHrXwnzty7i--
