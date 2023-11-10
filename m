Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F507E8390
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Nov 2023 21:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjKJUPE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Nov 2023 15:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjKJUPD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Nov 2023 15:15:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9267CA9
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:14:59 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3970782a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699647298; x=1700252098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd+JvFl7GwE5eEIj/Ew7unSI1M5/SrVTgPWAVUgLwtw=;
        b=J1nZfWCQ4LX9AbNpXTyaqiGnDefy3ppp0olejQRzs24/qq3PU3kxfkvFb8+GUvKCeZ
         uYFYLbqG1+PHXB8uzsvWCuicOOYiEaMNUDAmkf335fnj59jC7/tq6wMQjzAx+EQt2/RT
         RsOuVNxLBa9PVI71tEXLXTsyXTNG3ReJs4zjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647298; x=1700252098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd+JvFl7GwE5eEIj/Ew7unSI1M5/SrVTgPWAVUgLwtw=;
        b=XIfJC537SNAjHeQkBo/RL5OhhuOQ3gMSbsEdrpBccGMlb4RkKusIbvTfQo3zGo6aAV
         aIMCrJExhyQmK8UPcuXYsjm5FNvGZLQmdg4qhG9ziPl50m6n9xdf6wvriz5PZLs2mUAF
         /zUqC6m6kTnByNC5y1iN7mWdEJVMusi+8Gq/u+enPOP8hvoZOuau106PhAKgYg1KinNT
         91pzEDecwRTpZ3mYOoB8Jg+Tzyg1vVhVbI0xf1UHt7wuc098NgLd6qTbcxC+1xzNOZe+
         iIG1zc2tPHISvrzuBGv9ED4TqFgC1BQC3AzyRVkBnynxwiX7Li9NOSlR1r39RPmQdF+T
         bgzQ==
X-Gm-Message-State: AOJu0YwT7cW+7D1ZEHpLYwyAFxtt1NStmqp9g+ovLFJeyUtQ+n8aQvR4
        AmGTuMAAFPWb9nZ5VdGlkN9MF3TWfo/+IMyKAzRAvVeF
X-Google-Smtp-Source: AGHT+IHyZEIwmijsgpz4egaUa9P8ADYaLOJ44IuuC6jp+LRijD6JcHY+evmjsJYsd7VlrLLrRmYBqw==
X-Received: by 2002:a05:6402:160b:b0:543:5a71:85be with SMTP id f11-20020a056402160b00b005435a7185bemr264960edv.23.1699647297850;
        Fri, 10 Nov 2023 12:14:57 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id m14-20020a50998e000000b00546d9d81ec8sm25112edb.93.2023.11.10.12.14.57
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:14:57 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so3970757a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:14:57 -0800 (PST)
X-Received: by 2002:a05:6402:35b:b0:542:d895:762a with SMTP id
 r27-20020a056402035b00b00542d895762amr214327edw.39.1699647296966; Fri, 10 Nov
 2023 12:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20231110095013.655597-1-thierry.reding@gmail.com> <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
In-Reply-To: <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 12:14:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgXYxbw0-BoLne1A-x8wdgy1H8dQVLeeOPDRcUfeHRarA@mail.gmail.com>
Message-ID: <CAHk-=wgXYxbw0-BoLne1A-x8wdgy1H8dQVLeeOPDRcUfeHRarA@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Fixes for v6.7-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 10 Nov 2023 at 12:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I have no idea why pr-tracker-bot isn't reacting to this one, but
> here's the manual version of "it's pulled".

Ahh, the original pull request email isn't on lore either, so it was
lost somehow.

         Linus
