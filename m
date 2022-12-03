Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4564156F
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Dec 2022 10:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiLCJuR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 3 Dec 2022 04:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLCJuP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 3 Dec 2022 04:50:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64B686A1
        for <linux-pwm@vger.kernel.org>; Sat,  3 Dec 2022 01:50:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r26so9388721edc.10
        for <linux-pwm@vger.kernel.org>; Sat, 03 Dec 2022 01:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKoltGC5ckQWo5BiboUaLB5iAME4tB65clkoM0oEHcg=;
        b=h6dUD67vquHbmPgmHoNF3BOb+l8o5ggMnEOVhLjx1fn+5TL+D7YI6EIz+cJ8TyADBC
         QMFicDeDKirXMuYXDVisaijeLIK+QkKXdoD5bl83VGWDxAILefl2+EmDjB0DU1DwYEiC
         fJInYweXJ29/BR09WIL4Okv63iRAwCD2DyV3s3fFS83/4eHFZKswkJKmybe+cMIR8IjK
         4j9NGUL4lqQThbP4UPLaw83IPR9uzExrwlSICvd1mqCwiopgoSSljYq9qtIoST8ZFPfu
         kWCFMn6JaVEs2g4Usq6m/oab4yz4Iu1kIW1SyqyXocE71wlVKsJJIkyR1aHFbW18kUyM
         a28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKoltGC5ckQWo5BiboUaLB5iAME4tB65clkoM0oEHcg=;
        b=EvPag63HsFoEeMjzNBiDrEXQGk3A3IJ4RSn7vs9WILKqM178mhHXEbLfEEKzRk6kCP
         kBdV+mdPpnamr0segvXTCaLheApwnrqMEeMJ9xU4/3IzzluS2hrBTuFTHid6Nxtx9Vqg
         X90jTxhX0FM1VTZWsaJ+sVjE0UgZ7MCIw3Zc6DmLbAXhFmFBt4hzbDDtL8pQpdS61u9r
         UjM54JM3oZZHmm389wu2QgFTRPNOl/acatbCf7lOKqlzp5jZtTePiahSEAWEe61bnfJz
         xbscSOTdGMupMbNEBBI+VIHZE7/bX2di3/2u5SHB31ln6QsanVCkujhMGsr2RhbH0Iuj
         8qNA==
X-Gm-Message-State: ANoB5plXRN4NtRbs5t//HEbw26XCzIHm1i32+hNNFbRyNezJHEiDUIi7
        otcaRrEL+cc7A4XGNYD12v4=
X-Google-Smtp-Source: AA0mqf6J+m150CNoI5DgQbApXyAZL3nNTnv0RzKOkbOv7RUuirKufT3KcLNr3BaaEs2QCVel1ifT/A==
X-Received: by 2002:a05:6402:5406:b0:467:4b3d:f2ed with SMTP id ev6-20020a056402540600b004674b3df2edmr50133008edb.101.1670061011692;
        Sat, 03 Dec 2022 01:50:11 -0800 (PST)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id by15-20020a0564021b0f00b0046ae912ff36sm3861099edb.84.2022.12.03.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 01:50:11 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] pwm: sun4i: Propagate errors in .get_state() to the caller
Date:   Sat, 03 Dec 2022 10:50:10 +0100
Message-ID: <5623993.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20221201152223.3133-1-andre.przywara@arm.com>
References: <20221201152223.3133-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne =C4=8Detrtek, 01. december 2022 ob 16:22:23 CET je Andre Przywara napis=
al(a):
> .get_state() can return an error indication now. Make use of it to
> propagate an impossible prescaler encoding, should that have sneaked in
> somehow.
> Also check the return value of clk_get_rate(). That's unlikely to fail,
> but we use that in two divide operations down in the code, so let's
> avoid a divide-by-zero condition on the way.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


