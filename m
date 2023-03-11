Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D1B6B60CB
	for <lists+linux-pwm@lfdr.de>; Sat, 11 Mar 2023 22:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCKVBE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Mar 2023 16:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKVBD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Mar 2023 16:01:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF056BDE9
        for <linux-pwm@vger.kernel.org>; Sat, 11 Mar 2023 13:01:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o12so34180149edb.9
        for <linux-pwm@vger.kernel.org>; Sat, 11 Mar 2023 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1678568461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ7IjGprGZ7I/CKQDDDI8nwm0vwfXtggdGDsNEfxN4Y=;
        b=PiTR4FzIbsSL5+kTIFP/ubcw2RBvAk5N7feJGnrGwMllQ5gG3BPgXHRLX7Nae8KD8n
         Sx+QaOToeZYbO94b7NWHWdOALOnPjMVUaSl1n9GHO6aeSsKtcflaAM53ueFLYQuI4YWX
         0Czqwz3nyLQz7wKU+rw0jFsBe6W3FW5Qcc8T62fb+Q8jnw1Nasn6VxDB8NGjHK+nKOcU
         vQDiXrlQRTmA8/w+aLNpeXj0b7SFo4fznYzQ3NaOhATCN7tAZIv3SDzV+O1kNORZt4NX
         iLDVORHfRPBY1nW4RoDLCz3jiTnvZSVJxwHYRhquaky6bSOdgVUEF9aUY4/OwyUsvndk
         bSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678568461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ7IjGprGZ7I/CKQDDDI8nwm0vwfXtggdGDsNEfxN4Y=;
        b=K8m0PzLTBOz/R+FWmncg93bDJ7pbQE+wr3+ge9j9IjEDR0QkhbHmhoK9Gl+zOKxWMH
         KXZrWPWCFinhOTbd4XqBat513FCXe/1uuK67pg+i1c0VhhWWvySp/Bv0twjTLnbrn2xJ
         /7b3BD+FoyBJbIhts3bPVtjSZBbjpbDPCv2BQXiN23vIvN/ML7ylSI6Fk6wpf7EJVzhv
         X75o9CKQCoWN2U35VtYvfxzcmvWwSoYBPJogML05GcM5490c5+sls/3iCvgJ+JXCEX8c
         TZNWP57Qiqb9307sFh0gFFNVWXQzXTgLXW+DzBH2TtBiVxpF8tcPcFWZuaSqrgn0An/V
         kZSg==
X-Gm-Message-State: AO0yUKX5qhaiY4x9e87kLZgKqwGmfAnogdiNiS0MONmhiXttVcChzhVT
        ElFGmkHb7LY+G1DIreCquVr48eFFISGt7PHWnB/1GTa0JEc=
X-Google-Smtp-Source: AK7set+tGzVn8mUq9+ViKZpknU9hHzn5Xv/ej87PHZUE7Fr7JlB7GofkRlmbxccURntFrfOli+0CKD94Dktcdld9gCA=
X-Received: by 2002:a05:6402:530c:b0:4ad:739c:b38e with SMTP id
 eo12-20020a056402530c00b004ad739cb38emr4114413edb.1.1678568460834; Sat, 11
 Mar 2023 13:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230310191405.2606296-1-u.kleine-koenig@pengutronix.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 11 Mar 2023 22:00:50 +0100
Message-ID: <CAFBinCCfqgBkHq2fFy=d+8C6nwq=wehu9nzePfwuY5ndfLMWoQ@mail.gmail.com>
Subject: Re: [PATCH] pwm: meson: Explicitly set .polarity in .get_state()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Munehisa Kamata <kamatam@amazon.com>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Mar 10, 2023 at 8:14=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> There is a complicating fact, that the .apply() callback fakes support
> for inversed polarity. This is not (and cannot) be matched by
> .get_state(). As fixing this isn't easy, only point it out in a comment
> to prevent authors of other drivers from copying that approach.
If you have any suggestions on how to fix this then please let us know.
I don't recall any board needing support for inverted PWM - but they
may be out there somewhere...

> Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_p=
wm_get_state()")
> Reported-by: Munehisa Kamata <kamatam@amazon.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
