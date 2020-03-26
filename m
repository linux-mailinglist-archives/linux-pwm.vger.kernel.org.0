Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0096194463
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2020 17:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCZQhs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Mar 2020 12:37:48 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35700 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgCZQhs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Mar 2020 12:37:48 -0400
Received: by mail-pj1-f66.google.com with SMTP id g9so2635007pjp.0
        for <linux-pwm@vger.kernel.org>; Thu, 26 Mar 2020 09:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Z52Q+C+NI5sRvzCwNZXwgTHsc/eFf849vvv2BFT3moo=;
        b=DqAELuZErWTZ9hBELLMJ53oDN2Sud960uYRXs/thckf6EyZUJQdCpntPZ6YiACA6UE
         Z+zCiJTaK/dRm8nt5AoEc7YoZ5imYsqSlKYoSpqCPMovTb0u1k15+TbbzLhdajQ8qzhW
         OWqkLfZiJbn/ZbhDQGa5fg8J4mkBd2U6uIPDZ0o2huMMiFXD5eJAnGIuqz3DGKfFExWi
         JzaoAb3syFAjg4Ltucnzc4IBecoILolIB6T2fW9YHLlPPSjYSY/SHZEd8WQAaJUSfB2u
         FOwPTq3FOp2ZK8SjreYNkEhj3iqF/scAGPPJugkbCXYt5q/kwcrWUOwH68ZYKAIUdpse
         qc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Z52Q+C+NI5sRvzCwNZXwgTHsc/eFf849vvv2BFT3moo=;
        b=ESZ5dfEaSPRE4P7J2u9+Zmaj++D369FZrWsrX9NnTnu71tnK6lXBuczrfhQKMcugey
         aWOnW8JK+/CRB4xuYo/JE/NTC8SbNECiThxnzfn5KBbBm/hCNEmCkxJ4tshYOWx2xCWc
         0i7WjN28QOMUx7tHUz6Bdxex2q8X99KxlL6hU9EOyu7vvSYO190l1rGSzfHgCUd+oaFl
         r1MiwfDRfDLu/sw9S9E5NAXpQwSlqVjK7ID7RWVwYAQw+YLHHyy61GalSFiSFl5/NAaj
         y5/p/X6+RGdl2I+eY8+KiA+o3tqTAyXbcXFh5R2y5BXQcRDX9TIgM+5b1K+Jz3jy1mH1
         91dA==
X-Gm-Message-State: ANhLgQ27bizObIr3wlQ1XQdYNNuqpLNvhyGsxs7wUEeblEWzzp/AEoH0
        ASnv6aL32eR6Zn7yrWxPyJjOAsIo08A=
X-Google-Smtp-Source: ADFU+vtpKTz44UaLjK5rWW1p85dRlUFtlNTouBjZDGVUSoB5dNYxtvMdL9b/q3M0sgc1U6XZSte2wQ==
X-Received: by 2002:a17:902:6b48:: with SMTP id g8mr8800403plt.149.1585240665030;
        Thu, 26 Mar 2020 09:37:45 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id t60sm2053163pjb.9.2020.03.26.09.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:37:43 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:37:43 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Mar 2020 09:37:16 PDT (-0700)
Subject:     Re: [PATCH v7 08/13] pwm: sifive: Use 64-bit division macros for period and duty cycle
In-Reply-To: <4212f82b8711b2b33f0e71142526d5a7575564e9.1583782035.git.gurus@codeaurora.org>
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        uwe@kleine-koenig.org, subbaram@codeaurora.org,
        linux-kernel@vger.kernel.org, gurus@codeaurora.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, yash.shah@sifive.com,
        Atish Patra <Atish.Patra@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     gurus@codeaurora.org
Message-ID: <mhng-29ba8348-64c8-4113-ac65-1e81c0a1da70@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 09 Mar 2020 12:35:11 PDT (-0700), gurus@codeaurora.org wrote:
> Because period and duty cycle are defined in the PWM framework structs
> as ints with units of nanoseconds, the maximum time duration that can be
> set is limited to ~2.147 seconds. Redefining them as u64 values will
> enable larger time durations to be set.
>
> As a first step, prepare drivers to handle the switch to u64 period and
> duty_cycle by replacing division operations involving pwm period and duty cycle
> with their 64-bit equivalents as appropriate. The actual switch to u64 period
> and duty_cycle follows as a separate patch.
>
> Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
> macros:
> - DIV_ROUND_UP_ULL
> - DIV_ROUND_CLOSEST_ULL
> - div_u64
>
> Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
> DIV64_* macros:
> - DIV64_U64_ROUND_CLOSEST
> - div64_u64
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: linux-riscv@lists.infradead.org
> Cc: Yash Shah <yash.shah@sifive.com>
> Cc: Atish Patra <atish.patra@wdc.com>
>
> Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> ---
>  drivers/pwm/pwm-sifive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index cc63f9b..62de0bb 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -181,7 +181,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 * consecutively
>  	 */
>  	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
> -	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
> +	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
>  	/* The hardware cannot generate a 100% duty cycle */
>  	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
