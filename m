Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B1969AEEE
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Feb 2023 16:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjBQPEU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Feb 2023 10:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjBQPEK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Feb 2023 10:04:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D0359721
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 07:03:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m21-20020a05600c3b1500b003e1f5f2a29cso1184072wms.4
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 07:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XJQKMTqnEqAfk+bRGvjp6f9vM6mL9kn8UiV//TgZ0I=;
        b=TCTNUGss2bN4YsTODrtyl2H9/VhWG4EDm4zjToHhY+n0TWLb8pDQrWfN/UdaDqcR5U
         Ey+LASGssaNMIzErZUoMFcTWKKjzlEKOl1w65p0Cr/yITuE2NOd4evKkFhWaLerrXiaH
         ljxj5Qq3RPcCQi7Rw+39rD8SpCrzHOk/GPyJVbBt64s3NyYHGh0zhxsDO+uqXYLe/R0A
         Gk0kpvUI+Qln/6PnmOtMkbmB+QDWXICYRXZBRPSgFR+2DIQ0rAVmzkjxC/i/MWCvTOBf
         3Fm8NRs6l/SfIA3BUY4WfA+grP6L3gUJjMlMNaLpK+IrpCQKlxah0HaseWVZTKNJj/OI
         lW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XJQKMTqnEqAfk+bRGvjp6f9vM6mL9kn8UiV//TgZ0I=;
        b=SNRBoaRuNA0q1z/CoDw73DKFOkrNlsUrAhx+a4BAt2DRRgqqvon2OnnVYwtmbd8ctv
         duahc8Rps1vtZOQaIa2rdi1S4oPH1EJsnnWj77Bx1VM9UH3ix87t4jE38iYBmsBXRuEp
         mcMb+kNGa7T577pCOjIktWxKhJLkguH3BhTaRXpfvqXaVs6mJpEVMBlsdsL1H9a3gS9y
         /6texCs8xZ4ec9jTu1NjjHecZvAm8qThLcpU8uqrGsJ7dyxpHoGjZUDdOpX9C7OjbHfV
         X5tmAiSiRgI/XxBUyfEGWjLjlRs/2UV/sth/K2lpN2RfguCIVlijr9Eui9sJ414og4RQ
         sv7w==
X-Gm-Message-State: AO0yUKWqkaWuu778Odxrh3g0kLvqnm5INXdEk6ykCSZ9UB+0rVuoNch7
        sKfV0kicNUbkNu/sCiKIzhA=
X-Google-Smtp-Source: AK7set8lC/4tsamy2pn5sy2ejG8/A1bLJr28Q5JX7qaOZGa47xqiNTRvA3VfmyYXQaHJ7LQGLRwWzw==
X-Received: by 2002:a05:600c:c5:b0:3e0:185:e93a with SMTP id u5-20020a05600c00c500b003e00185e93amr1097416wmm.25.1676646211303;
        Fri, 17 Feb 2023 07:03:31 -0800 (PST)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c3b8200b003e22508a343sm2306743wms.12.2023.02.17.07.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:03:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [RESEND v2] pwm: iqs620a: Replace one remaining instance of regmap_update_bits()
Date:   Fri, 17 Feb 2023 16:03:26 +0100
Message-Id: <167664618724.3316127.16902771067863626054.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <Y+BsVlLp8Xqvg3ui@nixie71>
References: <Y+BsVlLp8Xqvg3ui@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, 5 Feb 2023 20:56:22 -0600, Jeff LaBundy wrote:
> The call to regmap_update_bits() which was responsible for clearing
> the PWM output enable register bit was recently dropped in favor of
> a call to regmap_clear_bits(), thereby simplifying the code.
> 
> Similarly, the call to regmap_update_bits() which sets the same bit
> can be simplified with a call to regmap_set_bits().
> 
> [...]

Applied, thanks!

[1/1] pwm: iqs620a: Replace one remaining instance of regmap_update_bits()
      commit: 860793bbdcdfbeae684d552ce0121846cffc4803

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
