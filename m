Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7ED6D987F
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Apr 2023 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjDFNqJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Apr 2023 09:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbjDFNqG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Apr 2023 09:46:06 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A765B6;
        Thu,  6 Apr 2023 06:46:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-501d3943f8eso1393358a12.1;
        Thu, 06 Apr 2023 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680788760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkHFpCD/XQeLxofMjQT3jwfPpJhgnEHgCex2rD4ksk8=;
        b=lKMqG7lIc47IvaYySaSBUJFH/hA+mln853cL8/jfrpRJEPRmwW4vpmxSTWBVyKIk18
         HReWO6yNVMsO8DPtbjjD0PjwHr5xKWAv3p0ciM7B1PSuvZbhJ80gT48ce5t2ve6posfM
         8hp9pp1wToANmgTh5LIwI6suCjGhAZbFfn8TETLcUpXPnseDFgkUzhl2RG+z5kgEBaJN
         rYnoAs3keLhepHWdqGD5Y50Sbv1R799at6hBKuSNACGwxqiHVOqc+tHpL4fsRIqm5Kfr
         SkD8e1NgX2/yzMkqHX4+EKa+0c6DEK/HBMIXvny7nkWaOrMZA/ROssHZBeHAIhooC9aZ
         kOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680788760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkHFpCD/XQeLxofMjQT3jwfPpJhgnEHgCex2rD4ksk8=;
        b=jVoTBXP2XmPqex4kXMxqoPQhbFbrZfVNVkaVLBX024dvp7Xwb/IvUV4TrKMA+JFXRF
         JNjufMbvpABz0fv1t/r/tZV2ELGclDNPzRfgOS8auNyAWMOP5wAm7OMJQfDxUuTv7H8e
         DSBC7k5TyO8R+Yiuj5fsnui8WFJt8LYqxJ4rLCxAdS7OmeRYI/ccCvtx3/05KWZCtxe5
         3RthXuqvzzPQxt5r7V4wAjomDeXzYcIZkRgFn8DhXjcqxSwIV5SaF3Bi9+TDjdBlKIlK
         iTqVjg3kkZknIwS/OdwEaznC9mR5DpwTDgrheH3uz4cxZTQq5jzGTkY0HfNC571pmp/C
         5a/w==
X-Gm-Message-State: AAQBX9efN5d3hYJjGfHW/WZ/yu+rM/qIPLYgu6WPoJsmixcr+Ye39g5b
        jaCO2biaCrhw90s7Fw2hWyE=
X-Google-Smtp-Source: AKy350ZFYf29eCxG6wCnL3JIuIp+ieQKorpdGdk2B232Ai9lNGOwLmUA+hdGHUvuhBjF8/BVi+o5Yw==
X-Received: by 2002:a05:6402:1804:b0:502:6726:89c3 with SMTP id g4-20020a056402180400b00502672689c3mr5410333edy.23.1680788760431;
        Thu, 06 Apr 2023 06:46:00 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k6-20020a50cb86000000b00501d73cfc86sm773352edi.9.2023.04.06.06.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:46:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4] dt-bindings: pwm: Convert Amlogic Meson PWM binding
Date:   Thu,  6 Apr 2023 15:45:59 +0200
Message-Id: <168078873512.1715717.5725405826072466849.b4-ty@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmail.com>
References: <3edc5ba6-bf3d-e45b-377a-9e7ece7642a7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 20 Feb 2023 22:19:30 +0100, Heiner Kallweit wrote:
> Convert Amlogic Meson PWM binding to yaml.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pwm: Convert Amlogic Meson PWM binding
      commit: 43a1c4ff3977f0ccd1d99e36d74e525aced5bb3a

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
