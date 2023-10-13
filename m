Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B967C86F2
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 15:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjJMNfo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 09:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJMNfn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 09:35:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489F95
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 06:35:40 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so1710971f8f.2
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697204139; x=1697808939; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVZGiTlsR5vucsTSYxXlUxyLQNB1qgk2sfAhILMMu6E=;
        b=FhlDKmCafEriJgEuqmUr0B/CNu+/wFW4/ZCSKOc5DQ2JSCuwNZkIZJ74vI40K0oP1j
         Qhr0Fv+yEUDu8DjXc+/fzKdQmnmI1dfWkLdocMq3TL/b/9T63IUZyqG4VjHVbVOHY2XC
         GCcDI0ldMxb04eZn6uD07K7ZGDPb3y3FUGSqfVN7yoLw8A1Nd+QQWrKhKxmwL71K8bM6
         zD5sn9RXta+ka7lVxc8HxFX/Dffwc7NEg84HSJ3Ftcr2+FtxsK2oC7EVsKa0us/RCYiu
         gp5MDwSMRLPBXpb3XeSC4kDU3Np+rPEnAZ/0+Ic0b+S3T9u2KkXihTt9tpos6FLNcofG
         Qd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697204139; x=1697808939;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVZGiTlsR5vucsTSYxXlUxyLQNB1qgk2sfAhILMMu6E=;
        b=Cg/P3s9ol10MNoMY3cX9H1NYGlS6l0L3MKMcEP6frNFenbxIBiV54eFtFEKytLVRSn
         ro4sgUI03Pw+yiXUVp5ZyFMOvKK+Bczk3S5gCsLtOFbHFfWBLJ5ha7OS07rQYm/7WCnb
         FrhJ/iYcwxpVoRrHIYGHNHmhj9AKzLWhqmOuNBN9SRoIwvYFz9eIg7zQEAzzIbGbb0Cp
         JIV8MeoqfSjLpAKu0Hx9Et4bJbaqwckmFm1HNhq+EvXoIjZCv1lxlflX1JFG2uvtklTm
         LPVUkysqSyotqjsDaW7EnKPFJRleCujVJ/NGTVw+czsx/jNNCYgJbMkLSECbfISG1X43
         iPYg==
X-Gm-Message-State: AOJu0YzglrBTmZzggrR7+c7p1LoNWBd9dAPhzhuAbt2T7FLXBghMXcro
        ZSTq98F6W/b0sz1passaOCA=
X-Google-Smtp-Source: AGHT+IH/xUuIlDEmVCP34N9wuEYuE7q47CVorgtvnDGvNXYQQyBSur3A04/CS8LVvi/NfB8HOTphxg==
X-Received: by 2002:a5d:6289:0:b0:32d:8c6d:cda4 with SMTP id k9-20020a5d6289000000b0032d8c6dcda4mr5399349wru.43.1697204138821;
        Fri, 13 Oct 2023 06:35:38 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l16-20020a056000023000b0032d893d8dc8sm6564856wrz.2.2023.10.13.06.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:35:38 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:35:36 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pwm@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
 functions
Message-ID: <ZSlHqOPHB7WaU0Pa@orome.fritz.box>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
 <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
 <20231011122152.00007595@Huawei.com>
 <20231011153112.44vfwedz4qxlunsa@pengutronix.de>
 <19a13327-e8b6-4bea-ac93-3b418f8845df@broadcom.com>
 <20231011164810.zx7upbermqvnv3n5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yefbooSPxPGunIdc"
Content-Disposition: inline
In-Reply-To: <20231011164810.zx7upbermqvnv3n5@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yefbooSPxPGunIdc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 06:48:10PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Oct 11, 2023 at 08:42:54AM -0700, Florian Fainelli wrote:
> >=20
> >=20
> > On 10/11/2023 8:31 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Oct 11, 2023 at 12:21:52PM +0100, Jonathan Cameron wrote:
> > > > On Tue, 10 Oct 2023 09:51:05 +0200
> > > > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:
> > > >=20
> > > > > This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't=
 have to
> > > > > care about when the functions are actually used, so the correspon=
ding
> > > > > #ifdef can be dropped.
> > > > >=20
> > > > > Also make use of pm_ptr() to discard all PM related stuff if CONF=
IG_PM
> > > > > isn't enabled.
> > > >=20
> > > > The additional change to potentially return an error when not doing=
 so before
> > > > wants to be called out in the description.
> > >=20
> > > Indeed, good catch. Something like:
> > >=20
> > > 	pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM
> > >=20
> > > 	This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't ha=
ve to
> > > 	care about when the functions are actually used, so the corresponding
> > > 	#ifdef can be dropped.
> > >=20
> > > 	Also make use of pm_ptr() to discard all PM related stuff if CONFIG_=
PM
> > > 	isn't enabled.
> > >=20
> > > 	While touching brcmstb_pwm_suspend() also propagate the return
> > > 	value of clk_enable() to the caller of .suspend().
> > >=20
> > > 	Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >=20
> > > I fixed that in my tree, so if and when v2 happens, this comment will=
 be
> > > addressed.
> >=20
> > OK so that makes:
> >=20
> > https://lore.kernel.org/all/20231005164728.1846726-1-florian.fainelli@b=
roadcom.com/
> >=20
> > void, and now I also need to re-submit:
> >=20
> > https://lore.kernel.org/all/20231004175414.1738475-1-florian.fainelli@b=
roadcom.com/
> >=20
> > or is Thierry going to resolve that conflict for us?
>=20
> Oh right, I remember.
>=20
> @Thierry: Please drop my patch and take Florian's instead. I mark my
> patch as rejected.

This series doesn't apply anymore anyway, so can you please rebase this
on top of the PWM for-next branch and resend the series?

Thanks,
Thierry

--yefbooSPxPGunIdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUpR6UACgkQ3SOs138+
s6FLng//S1LTk6lqA4JVEkDgswp1ht1L1jlBbc9bm7oUDlBjEa1qKszTdA71pHR0
BSG2cg2kZGz4vgDqbN4ZzNaxBaSrC7xG3ekKOgIDa7O4QwLWCRGw8Us51VL+goUg
zsm7oh3G3h3mCHGAOBlyZfRQYyequcgzOtCEqRKAR1KTXhD4GQZYn2MoCNeEVEq6
kEbTN1+7Fyst69GmRWftzDeyfr8zCB6HvJDv0FB/TMl+fmL4V8tpAc862Di9GEU8
yxCBnwDYcLeILCM8Bor9E/KQMV1R0g/tW5UMMYTMkc1dIj64wK5YBtPGIueypUlJ
ei8Hj1Ym9DZCzSpUQbeUPItrko8okmPToTV4H8vJHhhmZ9YAPsGa2FkZN4NA6nrK
e3faWjpj7CLiFAmP2agHDBmoWXkjvU9OcPRPdB2SUAKhZw09VCFk4h/GuBBkMu3f
sJ3t3e9H4LGxyox/9BjB/Uo4VOnkh7UvRoYI4uOkM+7YV3bJGjMKUY3IBvjSGTjg
+BEsV3RtGDK/plrmiiWGP3ly0TBJ0y5BR6qymLCR6rvS+uc56UP20fIABIritUn2
wrODp57O6d0F0VDQrb3SCMHsMC86QEwy+qN0ch+hTM/qGd48B2ACWOzKaRyV1Rcs
FoTPEeYm8+Xo1w9tW7dT+BR//jLr96C7W3sLq9dfTjW7JcqH1Xk=
=BVTs
-----END PGP SIGNATURE-----

--yefbooSPxPGunIdc--
