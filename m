Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E8516286
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2019 13:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfEGLCh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 May 2019 07:02:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40811 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfEGLCh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 May 2019 07:02:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id d15so13907973ljc.7
        for <linux-pwm@vger.kernel.org>; Tue, 07 May 2019 04:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EUu6Mnu44He2lWLLhgCEFkjsFkbhrlsReIpHL53zlc=;
        b=UEgMBfHkaLJK9vCowpe3BLuKl5J2UKHObPCuuSv/qaGx2Da93VxAe5Dj1SGZrQfwbY
         8TUgGK1QUznMXwBPdOy7ZThVhp3ERP6K6FnYHQvH3l+U64+pZV9p/xQtv4cvvl3J9222
         CGI0Zs2B8BIs1XC+fYBlOeUj+9PI/FMftXubnu8RBIpZC9vYg3MwCqZkTFD2a8ZhCxVY
         5JSRcOl36cZbnq2eMBMkuXpZDNNGMudPyH8uSnA9H18fl3cKfhaeiM4zAbYbyMKCIDMv
         XhDysh1BugLRHZwI8MHUhR+AQ7akp/rr4mrpuc/MA6KvB160hkprdSRo/Ew9qRUyqouU
         VV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EUu6Mnu44He2lWLLhgCEFkjsFkbhrlsReIpHL53zlc=;
        b=dLBKQVCooLHk27p53AyfBC9k9LEdA283w3O7sQObxSFu9/7Oi1R4QzdoOm8oj9DDi1
         +cXE2E5HVZKXYaQ5Lg4YYmIMGTtnab1PhFI24ALhmm7iT3zfObpnzhAdZto7pORasprM
         t5adjn52kzpsaArETHaUQ+7s1QzxActy3hJIcNewBn1s+pIXK8tnSyQCkwLfc5gQCmv3
         kxrfMy04wDfqoHIhlFRt8kqD0LkcBhN0odB9KkbvtRR0S1zA98Oyc6wSuR9d0vKbkKrH
         2tpWAtcsoYqKPa532gUbredtPR1wVjQ3mCsb/jGw5OUbYHhhDrK+zND3igkHfI4h1fxg
         EUuA==
X-Gm-Message-State: APjAAAXPPBHNV+GYAwSBYAID51Dlh4+RTouVJbpZGbLx4eC5GEqxHPS/
        4jNtBJgH9Vbsh5XMxJ/6njICudXrH/Zk9KwIq/wEGThrB0Stw7FM0rrxcE/FBeSMV9vEFg1cnRm
        GB7EE44DT+7Xs6369wPiGCy6RPCqqWQ==
X-Google-Smtp-Source: APXvYqx68N5jhHa7laODn/CQo4UzVADN8Md1na029xCAPAlTBaRQwWHs89c0lpBgg+yKBskHLkfyka0YUBiDmNZdooE=
X-Received: by 2002:a2e:9d0a:: with SMTP id t10mr1967057lji.95.1557226955058;
 Tue, 07 May 2019 04:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
 <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de> <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
 <mvmlfzisiwc.fsf@suse.de>
In-Reply-To: <mvmlfzisiwc.fsf@suse.de>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 7 May 2019 16:31:58 +0530
Message-ID: <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
To:     Andreas Schwab <schwab@suse.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andreas,
On Tue, May 7, 2019 at 3:09 PM Andreas Schwab <schwab@suse.de> wrote:
>
> On Mai 02 2019, Yash Shah <yash.shah@sifive.com> wrote:
>
> > The PWM default output state is high (When duty cycle is 0), So I
> > guess leds will remain on by default.
>
> So that's the bug that needs to be fixed.

Sorry I didn't probably get you before. I now understood the scenario.

Leds on HiFive Unleashed are wired to supply instead of ground.
And as per ./Documentation/devicetree/bindings/leds/leds-pwm.txt, you
need to provide additional property "active-low" in such case.

- active-low : (optional) For PWMs where the LED is wired to supply
rather than ground.

The leds will remain off by default when you add the "active-low"
property under the pwm-leds subnode in your DT file. So, this isn't a
bug in the driver code.
For DT file change, you may refer
https://github.com/yashshah7/riscv-linux/commit/dd55057a26150e50525643a423b20e07b72617b5

Can you test this at your end and confirm?

- Yash
>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."

-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
