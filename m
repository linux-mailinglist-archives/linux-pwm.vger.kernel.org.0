Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDA3608BC3
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Oct 2022 12:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJVKlA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Oct 2022 06:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiJVKkl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Oct 2022 06:40:41 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6A22EA0EE;
        Sat, 22 Oct 2022 02:58:08 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 507461C09E8; Sat, 22 Oct 2022 11:57:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1666432625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83ip+AQRESMazAv9HKl4L2Rx4DdvpNEVqCCemuG21g4=;
        b=ZBQ6ZnD5e2gWdlEEFRikTZ/Q/xhdoXQ7d/pxWI9g5ESX39228ffhYNMgrHwXNbPQKpGdbt
        LTiGm9IL8bPxUa89uisNSumLiVeXRL6dYj2qa3UWPaTAplZOtkotgB0exKboih+r7UtDQL
        p6oge34KD8JKCo3AkXxW+epWp7NvIoE=
Date:   Sat, 22 Oct 2022 11:57:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH] led: qcom-lpg: Fix sleeping in atomic
Message-ID: <20221022095704.GB10427@duo.ucw.cz>
References: <20221021191940.2422408-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <20221021191940.2422408-1-dmitry.baryshkov@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> lpg_brighness_set() function can sleep, while led's brightness_set()
> callback must be non-blocking. Change LPG driver to use
> brightness_set_blocking() instead.

Thanks, applied.

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCY1O+cAAKCRAw5/Bqldv6
8nUoAKCytT7XpbqwvVvUr+89/Y7qgsfa6ACglJJzCvaxs2vM6VQX0jJpDfqYwC8=
=QDSy
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
