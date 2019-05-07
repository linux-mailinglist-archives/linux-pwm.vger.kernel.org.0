Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84776167DC
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2019 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfEGQ1E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 May 2019 12:27:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726738AbfEGQ1D (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 7 May 2019 12:27:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4364CAEB5;
        Tue,  7 May 2019 16:27:02 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v11 0/2] PWM support for HiFive Unleashed
References: <1553508779-9685-1-git-send-email-yash.shah@sifive.com>
        <mvmbm1zueya.fsf@suse.de> <mvmpnqcsn6u.fsf@suse.de>
        <CAJ2_jOFu-yCZV_A4B48_fLq7h7UA6LUWhgpxr0uuh7vhW9Q8pA@mail.gmail.com>
        <mvmlfzisiwc.fsf@suse.de>
        <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
X-Yow:  TONY RANDALL!  Is YOUR life a PATIO of FUN??
Date:   Tue, 07 May 2019 18:27:01 +0200
In-Reply-To: <CAJ2_jOG2M03aLBgUOgGjWH9CUxq2aTG97eSX70=UaSbGCMMF_g@mail.gmail.com>
        (Yash Shah's message of "Tue, 7 May 2019 16:31:58 +0530")
Message-ID: <mvm7eb2qlgq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mai 07 2019, Yash Shah <yash.shah@sifive.com> wrote:

> Leds on HiFive Unleashed are wired to supply instead of ground.
> And as per ./Documentation/devicetree/bindings/leds/leds-pwm.txt, you
> need to provide additional property "active-low" in such case.
>
> - active-low : (optional) For PWMs where the LED is wired to supply
> rather than ground.

This fixes the issue.

Thanks, Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
