Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB686A8224
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Sep 2019 14:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbfIDMLA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Sep 2019 08:11:00 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:37461 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfIDMLA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Sep 2019 08:11:00 -0400
Received: by mail-lf1-f47.google.com with SMTP id w67so15702660lff.4
        for <linux-pwm@vger.kernel.org>; Wed, 04 Sep 2019 05:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Sbn4WvhXi2SN97WE/ER2GcVDBNdL4f0DKQLlN5gdE0=;
        b=bZRGOE4Ms77c7h0UOMkhDbatEyZAWh2VW6IMNk3uARbJjb4XIofOOLvviyixJaAYrl
         oVtfmKGHP/7y4mi65n6HjQIGikLHBuJSAwNjHPzQBqNmwES8tddVfJFDqpiE8Wn/yQ6g
         FnA8Hic8ao8aoGNgVqujymjAqF6wb2t6ERzP65c+ZP/EkpCJk0Sh8lwAv6hTEcGWeHD5
         tkvW41DOIg9r+xc/A8qrrNRL2AiNoV+/jRT2BEanT4AXb4mecZNf0qxyY5dxF7vXqsC5
         wg8w7wkRTdTeoh1uh2VennsUHcMYR0dPVthh/njgo/7eBmBOnFP3vSi9sFAVeM+g18JX
         jiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Sbn4WvhXi2SN97WE/ER2GcVDBNdL4f0DKQLlN5gdE0=;
        b=FmRd6mlbKFURnDnXHEsJvYsleIqZGEEhcjbb69TkUXmHfqHCXTMTsCVHikQbc6F0U+
         vXZUMShfJ+yiUoOY4eWCerqgYVkhmD0HO0Mi3eIECv3Sc2kmCK4otudOLj2Jpiyk0w2J
         S12ZDQdfQhSQBFvPsQVwhwNYxLot3dZ4zDLvArfasYPwBEvbj0bWsbfnF1EDpUbq/BRW
         QLAM3nKmeted4fyDctlAaA0adjNz8/RGsqg3A0P3mXWeXJznRPdI73AZumUhNkcgFVUB
         Rsj4gKZoF0hu+JooYjPsLfKsMcnsOZYWd+kLWX4TJ80GcI1fb0r9OxPH/WW4KS2wHtWF
         YPJQ==
X-Gm-Message-State: APjAAAVtwAWTc8odzcNfH14S0zHZ+Lywc5/L1msgpr/ZMvktQk2UfoiN
        VrChTgI1IxI/pChMTTZXbI/zJkYKuMcLdCj+NLMrxThf
X-Google-Smtp-Source: APXvYqyuMigwoe5rk8OKUmkhLwr0krRPy5cW4X1jr5B7Y2tY07Q8fTwkocKNhiYQuS0GgYymYYMmI70dnX0r3fXsja8=
X-Received: by 2002:a19:2207:: with SMTP id i7mr23806501lfi.185.1567599058577;
 Wed, 04 Sep 2019 05:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190904111836.122616-1-weiyongjun1@huawei.com>
In-Reply-To: <20190904111836.122616-1-weiyongjun1@huawei.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Wed, 4 Sep 2019 17:40:22 +0530
Message-ID: <CAJ2_jOHMu3V=wv7mThSw0A6wMkE1N_=sN3_8PjEOw+cLPO94NA@mail.gmail.com>
Subject: Re: [PATCH -next] pwm: sifive: Remove redundant dev_err call in pwm_sifive_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        kernel-janitors@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Sep 4, 2019 at 4:31 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pwm/pwm-sifive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>

Reviewed-by: Yash Shah <yash.shah@sifive.com>
