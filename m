Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975D07E8380
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Nov 2023 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbjKJUK6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Nov 2023 15:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjKJUK5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Nov 2023 15:10:57 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BF1A9
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:10:54 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso7110313a12.1
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699647053; x=1700251853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UaWQSRQzi/7DA8Jzdisd3TlJK2VMiM2u767TaBKKybM=;
        b=cXksBSP2fm8aWPZNdifFg65Yke0PQniAYndu8lxzfGIaN7fVcyvKrHaHyMMVeCgv7D
         lzwD+xRHiFYnZHmdehJ1OADKJ1M7xh0AExCCk2rrX1LyxPo8dlM97saa7LlL6/HBX89g
         m4wK8ygB+4qCBdR+8airCW4H5vz53Fjmc4YWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699647053; x=1700251853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UaWQSRQzi/7DA8Jzdisd3TlJK2VMiM2u767TaBKKybM=;
        b=BxfNCpbI5eQGocAUA9dMN6MawYYfuIcIoUUFAC2FvkpT7RVMwDYTvFo9UdJAY68mKH
         lWSy5+HJX4tJtI6IVxdpfPi5kDAHQLtN0BNPNLPfA4aAWpIeG58Qz5ZiiF6CWJpkfue3
         hu7et28SE8Aovh/fCZnboss3+Mw3tBAX84DEo1CfLIW1RYAOC5mSA0JNBF5GsxssIOM/
         u4KbYrS4F1vtsVKk26NArkgfpDLQsUbD2lk/LDEswr+cYtweJQUm0w2KoVWu0u615Yss
         zEtB64lzkIPRR4hC3VKPjzHBOEhXslhpuZdB5FCMJJOYYZ03AegavcNAo9L2fAdgDs3d
         sUtQ==
X-Gm-Message-State: AOJu0YwnxqNetvVwBJ1gjIAvyVNorx2JAn5RDgUg5IH7yMedKBlOT+lw
        j16rbc5lhV2n4ZzxA9nStJ5qudIQAH7PcxTmzFo0WSda
X-Google-Smtp-Source: AGHT+IEiOh84WPCA5bdBPE3w5eD9TrQIU2j7UkPYJPGXr1rWCupnLeEfu66LZu2lFAQX5mjC0ERnfw==
X-Received: by 2002:a17:906:4e4d:b0:9ba:8ed:ea58 with SMTP id g13-20020a1709064e4d00b009ba08edea58mr140724ejw.30.1699647052753;
        Fri, 10 Nov 2023 12:10:52 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709066bd900b0099c53c4407dsm34906ejs.78.2023.11.10.12.10.52
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 12:10:52 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso5001046a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 10 Nov 2023 12:10:52 -0800 (PST)
X-Received: by 2002:a05:6402:3514:b0:545:52ff:edef with SMTP id
 b20-20020a056402351400b0054552ffedefmr2843522edd.20.1699647051822; Fri, 10
 Nov 2023 12:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20231110095013.655597-1-thierry.reding@gmail.com>
In-Reply-To: <20231110095013.655597-1-thierry.reding@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Nov 2023 12:10:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
Message-ID: <CAHk-=wj=-dpdJv54NMawHSOZ_aM3oeaTdEVDeQM5OS9+5bi2eA@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Fixes for v6.7-rc1
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 10 Nov 2023 at 01:50, Thierry Reding <thierry.reding@gmail.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1-fixes

I have no idea why pr-tracker-bot isn't reacting to this one, but
here's the manual version of "it's pulled".

              Linus
