Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD46C7665C3
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjG1HuX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjG1HuR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:50:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C8B35B5
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:50:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3176a439606so1799039f8f.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530609; x=1691135409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWZjwy6pQMZHW/ycR5wFpCkUrH/I+MWTyG22Ld0AHd8=;
        b=Uy6IkQaEmOV/1fJt3P6huXOnuoGk9Cme52stmDNgJdqhsRNv9QwZfii2+tKpcrN4de
         S1PG1PR0S5LLSETCx0wEwwi0mMEHM2ONhsbt0+VMvuOsBxYbdoSRM8WW3NdWSAqmOaQc
         WopD2MIg6XGAg5ZW8l1zv3yr0S80+O6zz3USor1uP0tYxSLFmwmUJzCOC6jHt4fGD2dc
         2S82gNtQ9H3/LeuQpfBUbdKEaNq1RxlOAc07FFMXZNm/j5EAdW/VJWpSAgftJxbWl2Q3
         6Rd1X6OL46dgsVqmSLbq+0IIDCOnBZNAj4Z2qjdRS4FKaf9nlm8c2qrJ9rllvTqpmsqx
         7X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530609; x=1691135409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWZjwy6pQMZHW/ycR5wFpCkUrH/I+MWTyG22Ld0AHd8=;
        b=M9lJJ+nJU2uMCVKD3rkg9yKeqkKSOSV9kDMq2APZ88H4YHfgyGLtJacwxaeQangxaP
         ENwfRT94HTas0Ex55leuHbr+MSoNBRP55M6s6oAAeFxp3TjXkiKmNvvSQxKnnUC8nGdJ
         W+h9zL3RPiC+9CXXrxEbwlztIKhHMClWXfOWziMbeaKgKNUZ4j184S7qGfiip8jTjcXB
         k5DWiQb48cdb2ZaAJv/kRvr+5NAf4FXAVCY1wcKs0rCFwiEdCBrupgQGTeTpmRHZPUMC
         FN0jd2YRWqvQ2YG29+pZ1QdUkS0g3Iat5cVRL1cqBh6b09hsCpfFGtPGLpTKo5cq9nwH
         t2mg==
X-Gm-Message-State: ABy/qLYxJdmw+8TZqe3VxEYQIQzA6qo6Nq16g0E+fMXT9QhVXZ0aiIzX
        Dim8xbGV9A1EEveqKmp8Is8=
X-Google-Smtp-Source: APBJJlHe4ONFltmWxzM/BVnupMzDT/EG73Rf4UqSyTDBTwWvbIflEbZnDfPnIl//KPUlUn1Cbbg/rQ==
X-Received: by 2002:a5d:674c:0:b0:317:43de:4c0a with SMTP id l12-20020a5d674c000000b0031743de4c0amr1143071wrw.20.1690530609050;
        Fri, 28 Jul 2023 00:50:09 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m2-20020adffa02000000b003175a994555sm4181480wrr.6.2023.07.28.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:50:08 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] pwm: stm32: A (small) fix and a cleanup
Date:   Fri, 28 Jul 2023 09:50:06 +0200
Message-ID: <169053057430.3515253.9220792753851124413.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
References: <20230713155142.2454010-1-u.kleine-koenig@pengutronix.de>
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


On Thu, 13 Jul 2023 17:51:40 +0200, Uwe Kleine-König wrote:
> I was surprised when I spotted the stm32 calling pwm_disable() in the
> remove callback. I thought I fixed all drivers in this regard.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (2):
>   pwm: stm32: Don't modify HW state in .remove() callback
>   pwm: stm32: Simplify using devm_pwmchip_add()
> 
> [...]

Applied, thanks!

[1/2] pwm: stm32: Don't modify HW state in .remove() callback
      commit: e9c2f69aac05919a4f2bf72a7b53c43ac3f4c410
[2/2] pwm: stm32: Simplify using devm_pwmchip_add()
      commit: 8c89fd866ad221af037ef0ec3d60b83d0b859c65

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
