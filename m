Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8417666B3
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjG1IQ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjG1IQ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:16:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4910D2
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:16:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so2636779a12.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532213; x=1691137013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rjm7OU3KYHctSLavDlRLOkpPQWX2nRrpsrd/3qHypYM=;
        b=NacA+daq68xgpGh+WKZNh1L+MIZSdmqM831bwVk5GidC1TRpiWJkLkHGnnYvVa7st5
         UttWhO6TUMK+BnhdeDcaWEHUIj5yIFp33VfwguSfTONXG4YI8UPl3UV2XEgzyeZts9iQ
         MG5muzYgy0XeSKdiV0guW/XEgH+7Ueb5hoa8l4X+VGjyaUFFJjVj2YyG2xWQ3/T6gXO/
         pFOxueHpMW/xCH66wAhmicWABqKiny2lInO8i6ToPX57s+r8QbmFXO4Ei2jR4u4zSOax
         //+8dcqpF3Hvj0OdHccHSRhNA6Lj7vbGAxY6DD7jSCLXyofawrRAkr2B2UwQOmqKq0ri
         mRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532213; x=1691137013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rjm7OU3KYHctSLavDlRLOkpPQWX2nRrpsrd/3qHypYM=;
        b=GJfVzMCBZ1RlN+ADHLC/d6aLvONtYcOmCEXEeohNEVQYYmF1Cez1ASLU9pPINUkutr
         w/mLiuHXnt2NtvnfO6zJFXfONiiWKkKNiRijReZYXQFttlSrx1V1NwH3hhtIqSmQyPyO
         K7yVajzZ2f9WY/FlLCfDn42u5JFJkQg1ltvig4rynek3pnxZX+N4orl+vDTctXgBRiWS
         6OaIyAARmjl1nVBw9r7RmgJRqqu+PANdeqs3yU+hNWckPh00ZkFREmtdTlInBudNADDy
         FcdrqeI8GP+yo5/sIN8MtzmpAA5WEXznfwNqSY5V86LBdYsvRScJaXRbTBGvnrPkc8JE
         YqjQ==
X-Gm-Message-State: ABy/qLY+1UdRcmWOBsXhUFPX+OpO8v/h9D9kGV3GKp8VRkhIT/rQwGmO
        SOwXWikUSyryMygmlQMMU5w=
X-Google-Smtp-Source: APBJJlE0CmYLncTpKu4CAKaQlpsPkN+sEFhuYxUVJtgv1ZobaDtTlEJ9Na3fXxeERKur4AN5o1lzgw==
X-Received: by 2002:a05:6402:b0e:b0:521:7a5e:ab1e with SMTP id bm14-20020a0564020b0e00b005217a5eab1emr1571266edb.21.1690532212922;
        Fri, 28 Jul 2023 01:16:52 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w5-20020a056402128500b005227da4bb9esm1519277edv.62.2023.07.28.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:16:52 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Vladimir Zapolskiy <vz@mleia.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: lpc32xx: remove handling of PWM channels
Date:   Fri, 28 Jul 2023 10:16:51 +0200
Message-ID: <169053220434.3517248.8491558822242570562.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
References: <20230717155257.2568627-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Mon, 17 Jul 2023 17:52:57 +0200, Uwe Kleine-König wrote:
> Because LPC32xx PWM controllers have only a single output which is
> registered as the only PWM device/channel per controller, it is known in
> advance that pwm->hwpwm value is always 0. On basis of this fact
> simplify the code by removing operations with pwm->hwpwm, there is no
> controls which require channel number as input.
> 
> 
> [...]

Applied, thanks!

[1/1] pwm: lpc32xx: remove handling of PWM channels
      commit: 6894c2373e9fc8deaf26f9571f1e183c1ac91120

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
