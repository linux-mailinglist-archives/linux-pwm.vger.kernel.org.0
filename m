Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D07A191F
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Sep 2023 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjIOIqi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Sep 2023 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbjIOIqh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Sep 2023 04:46:37 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56141FD0
        for <linux-pwm@vger.kernel.org>; Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59c0b9ad491so5264177b3.1
        for <linux-pwm@vger.kernel.org>; Fri, 15 Sep 2023 01:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767590; x=1695372390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7dFja858QAKd2jvGSHcGoeN85VFrdz3aCMi8eOpyFA=;
        b=Qv+lp2vaf5IgAttGkMjq1e0bRJcsp1hRfEahpLM4TZVNwdmueWhXD99JWBffKw0E1i
         NJ0AX5guWmNZ71ZFJL1K7cTnds73NNIa1CQmdYDMNgNxxvOns1+CGZxu0bGEBj1qnZLN
         cEtF2Qy9o7AWlQd76hmxa25b4ee8FTRWp7EM9LPVuBP3zEPTsjretOmoEn0yHRzZ3KBD
         VkehbrPfvY36ug+cwZ9GVWTkq60WAiztjExi0Mvg5Fg1ANBOSVne7Kj4mlCV3xJXRAX2
         m0r6PPgtJ6o+cz0eD+Kn5i8qsnpU2zNGEGz7LCmKhe9qBKeDCg1ylOv+G71JQ/pKGb33
         7DWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767590; x=1695372390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w7dFja858QAKd2jvGSHcGoeN85VFrdz3aCMi8eOpyFA=;
        b=iir5Yg5yXwO2aEiD1IfL4T44aQ4U5KFaak9fvUvwdpgaPljIKnBNYLc0q2R9J+GCSH
         I5EN5VJXNNlQCxHB87gJuaIdcQwOhQeh4Y3ZYCLscpAdljU3Z9K4j29JJU4Y2pHyChbi
         6gMTRKzx5JaWn6FY4iZTsM+iDC+yoPtlGsHb2taOoYRIsbzMsDd6vHs+h3QjVyPYxww+
         Vtw/5N7nAv9GQ/LvQ+UtPRYBbw9hkzrcYFuSalC32WCwD9T515+duiMRQvVDdJohI86G
         VB0s2URqzqm3BCRvYHKUgPNOTWTM9vIUtTwuqz12+MFizGMQq6vi/hRRMiiJoPys24GC
         8uaQ==
X-Gm-Message-State: AOJu0YyKFMzzCpCPCicpErrWTwtx2pzt9NJDyJHqyRm9KVHsqblqPoFM
        5rllAIjXubfp25Wo4SHlUQRJPT2SAP/sCD0A4vnRWw==
X-Google-Smtp-Source: AGHT+IG6Q+IiSNhWJfwPx3EF9XH2lhzXIA3xdYaGMvC2dGwJ664Mu2IM0zshWn36EazY6A9blfT5yhH+scmlNrxCGug=
X-Received: by 2002:a25:b08a:0:b0:d81:c4d4:9e86 with SMTP id
 f10-20020a25b08a000000b00d81c4d49e86mr760227ybj.64.1694767590080; Fri, 15 Sep
 2023 01:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me> <20230915-ep93xx-v4-37-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-37-a1d779dcec10@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:46:18 +0200
Message-ID: <CACRpkdZeu6+839_E-yDH0yi9Ma6MzhjfXcvhXDjeLoFnH8TP5Q@mail.gmail.com>
Subject: Re: [PATCH v4 37/42] pwm: ep93xx: drop legacy pinctrl
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Sep 15, 2023 at 10:12=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Drop legacy gpio request/free since we are using
> pinctrl for this now.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
