Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7970BFE1
	for <lists+linux-pwm@lfdr.de>; Mon, 22 May 2023 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjEVNgJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 May 2023 09:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbjEVNgF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 May 2023 09:36:05 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C86DC2
        for <linux-pwm@vger.kernel.org>; Mon, 22 May 2023 06:36:01 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-ba8a0500f4aso3992387276.3
        for <linux-pwm@vger.kernel.org>; Mon, 22 May 2023 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684762560; x=1687354560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm6AtU2+OuBX4llFg1IO4pE7VkjWX7FicmeHdP7xHo8=;
        b=kjyW5gc66/F3uTbXesgGX49WSw+dIl51v4d/Va824zEUdwv/PfUv+MSIoJ0bvul5fO
         4GDCS2cij488fH+RgarG2Nkip2cdL4Q4WXqi78BnvfItHa4krK1XgEunE3PyPng/X//j
         sCAKGeYG2LYtOyqwzJmQffEcCi2uhjuvZN88hiFe+x42HxB7ZXAdxlP8MGHteJS9aiCg
         JJyjzdamE/qO6nYWlv6dw8c/yfES6DHR5ZFYjSFeJdlhulosXxL+jk23AfgCVX168mVt
         lXirdCfJQwYieQ2ZNtw/iNcWTyfmydWkd/sS8a/xUfW+rTfziwo+zjLbcDzy/gl27d/Y
         NGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684762560; x=1687354560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm6AtU2+OuBX4llFg1IO4pE7VkjWX7FicmeHdP7xHo8=;
        b=FZYBH/L2Dy7KLabMItvb7Ty99p7UV9KjApKldn+cJRCYvhbDvR1NqYMlKblZ41cFQ/
         UBfg3UiRu2bMj6+KTCFFaSXc9fHeS+tMgJjRoHEJ3xwU3vflscJVmrquhM0yOv1mUKt3
         Xxdy3/PgS9F33ZkqyAkBw0846K4yMsU4Wx4pBLbLMqE0oar/mnc5jrLN+t5GVNyvCCM9
         trM1yiJw/2hU/NWuFc0V+lsXz2auN75vB/z/ngq+cxWWxe5tUBZ/PbNVhi2RjCEQxQmW
         m/qG1Eq1gU6ntFDaeNmxFEbKjTGScUO2OIDhxNlJDXK/SGpSFWloajrVb8zhp5OVj3Wf
         48VA==
X-Gm-Message-State: AC+VfDys//Llg1fA1aAwZnJscXDmxLKTnbmfU5ypZaNwTrhuGd3b7e+V
        rsKtUuBUF8Zmlj5k1riL5Pr2Y1Ba4s6OwkdU4pYMIw==
X-Google-Smtp-Source: ACHHUZ7cEG8y3tp8stsvn7L0Bpoi51bVVFj6a4KIR3GU6ZdWQMI2zycbhRo/A0NMAiSWxeSPAr7uN2ggRaMlsBN0JdY=
X-Received: by 2002:a81:8390:0:b0:561:e71d:2618 with SMTP id
 t138-20020a818390000000b00561e71d2618mr10734264ywf.8.1684762560692; Mon, 22
 May 2023 06:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
In-Reply-To: <ffc1e98d-0db4-4b8a-9e49-eb87ef844cbd@kili.mountain>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 15:35:49 +0200
Message-ID: <CACRpkdYogcTJ7LLD8Fh-=KjvRJuBFP3=pi9=Pv3E9tvuk3X1Cw@mail.gmail.com>
Subject: Re: [PATCH] pwm: ab8500: Fix error code in probe()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 22, 2023 at 1:07=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> This code accidentally return positive EINVAL instead of negative
> -EINVAL.
>
> Fixes: eb41f334589d ("pwm: ab8500: Fix register offset calculation to not=
 depend on probe order")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
