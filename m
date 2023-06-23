Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C01B73BAA0
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jun 2023 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjFWOvu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Jun 2023 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjFWOvt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2023 10:51:49 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9513E;
        Fri, 23 Jun 2023 07:51:48 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3128fcd58f3so789822f8f.1;
        Fri, 23 Jun 2023 07:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531907; x=1690123907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhEGgV3JXLiXw1/qHmQYjniJ7Cai85vCH5T2anU1nYM=;
        b=NwXkfW58h/YvcjITHUEa0OKLCFkxNgAawC1qf1U/eoJaMPCGszmGKc/TfN8Agk8flP
         qiRVRKUOz66tgPEFJ9b2RMbBta/rQvjKfU71+fjtmLbM93zqPFwfFOZoEZWU5as8cQ7d
         mkf3wLj+x37NReky5E5NjXp8IE/J1/5F58zIkYeqqPHgnVFf10JSUynfDAANyuu1moCY
         xp+1V9i1eMoa6O/tMIKHOL/D00+Oy/ui6182cBycpRgdEjV9jjRWpL/oBYlWw6hu7znW
         ovoj7+v+f3gr5lCckoJH2DOoLInGg5ZWHGWfVs4yufWflmNBQ6xJne4vKjw4RjVX2hvj
         z7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531907; x=1690123907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhEGgV3JXLiXw1/qHmQYjniJ7Cai85vCH5T2anU1nYM=;
        b=VcP9/8vtFoO7LAr9r6RQofRe1JhDrGmUn9sdEhhEc2uAwWN3aWrnGhwQZkeLQllHn0
         kaNoYEtf40dS0oPh1i2ioHRZqFNQU+XXWGElyeDnxfCZK2pLXRGHz+3WWvgzaeuJ8ahZ
         inVX4mtHFrooJd99P4GGcxGce5bPgkgC0Bt/Rqyj5sa2l/fH+7L7SPTYeGM94jkyb/QL
         JTGNyziwD/nUhJPAbx/h3MHRMb49duKgcXBGNcdyzEG+xT44WxN4c00ipbmm1oM6dmJc
         6l+AwPQIpAc3Vi3OoFQCyLJ2vh5xOQtC0oHZ+STNZ8RmZ8T9J9r/ER4/aPbLmZtpZ1Bs
         Didw==
X-Gm-Message-State: AC+VfDzwfYzo4UKsF7nN8CvNmzpddC+M1CEYT+zDvbHTVf0G1lPFjQ75
        ogZpe02c2zqMB98OfFtw/14=
X-Google-Smtp-Source: ACHHUZ5MR/PyMCf0l+4lhNdnIxFJBo88OdHHb7CHzzEumFyzGm6Wj5RTNK/S2SZiXCD1IR5QxTcMMg==
X-Received: by 2002:adf:ed8c:0:b0:30d:5f9e:c29f with SMTP id c12-20020adfed8c000000b0030d5f9ec29fmr16780723wro.37.1687531907061;
        Fri, 23 Jun 2023 07:51:47 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id r7-20020adfce87000000b0030af54c5f33sm9732539wrn.113.2023.06.23.07.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:51:46 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v17 RESEND] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Date:   Fri, 23 Jun 2023 16:51:30 +0200
Message-ID: <168753171981.1191890.2592665609129144690.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230602101121.227556-1-biju.das.jz@bp.renesas.com>
References: <20230602101121.227556-1-biju.das.jz@bp.renesas.com>
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


On Fri, 02 Jun 2023 11:11:21 +0100, Biju Das wrote:
> The RZ/G2L Multi-Function Timer Pulse Unit 3 (a.k.a MTU3a) uses
> one counter and two match components to configure duty_cycle
> and period to generate PWM output waveform.
> 
> Add basic support for RZ/G2L MTU3a PWM driver by creating separate
> PWM channels for each IOs.
> 
> [...]

Applied, thanks!

[1/1] pwm: Add Renesas RZ/G2L MTU3a PWM driver
      commit: 254d3a727421ccc935f085eaa9bae51cb6c9df25

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
