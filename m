Return-Path: <linux-pwm+bounces-8993-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM0iGJ0yDGrdZAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8993-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:51:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1E857BA44
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F5A9300B47D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1D3B47D8;
	Tue, 19 May 2026 09:49:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC23EFD34
	for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184152; cv=none; b=kOJtNl4EXE/rRbeb1TS0yznnVMc4f4f2g+wYf7T0dzfFHEDt/8YLlaqxs4zJLovEk0W99XNtf8bkVNi9SPHhIv6zzQwRc1N84dfA5H3okbXxUxFhWIDhq7YMDWlPrKfUZjUV5e3+sLJDPzo/x4uxvzcYDowuS9xyBDNq2IcX57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184152; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qmAfss1i9GyERJaLka8IOg97Wej3U85ve3sJp3l+dZkR+jRLHP90l4y74ICGDjQAyGzwwf5M6iD8vZI26qhoMjRGJbqc9ZgblKB5UYp5DWfckMR/G9grzzfjqXyM0A1D61Cwj9N5aiT6g0y6qFvPsn33mPn6oC+8PDJp6Og8c88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbcb467f2bso3313898a34.3
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 02:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184150; x=1779788950;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=O2MrnTF6Y6qik81xV6UhoqefZ+RpZPERAcQAO6CdrlbBB6zUu6jkxtNuzGxF4n8u8E
         zm17LYMaEft7EdB2g5Yne0NyUONmxDAVdc1+UYHLUQCFPH9al/YkKE7nOw6O/orQ96cm
         OpQlVe3iNuvj1hz3L0XiAOojnfvdJVx8OckKvpOi8TSnOaqz678ydrV95Rb5mZ1KkqKe
         TB8EXAae8mFCsUoI67AuB67RUCuyHH7JzAoIJtk+qndaewUv7h/9WXC71ORJFmknd4TA
         5LHy0I3GbbtDKgAFu8h65ZREXESP/Bm/G6CPTHlWL/s2FxSYIoU+pVB24ebl8MhQTeVs
         bENw==
X-Forwarded-Encrypted: i=1; AFNElJ8jtBB/L108USJQRHJ6BeCwXw8eEJqPKYM5yGxrFs5D2jk+c9OylQS7AUjnBwD2qEneSI14yEpn2GM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTwD9fZkkFJuUhbY5bxzy5YSC3gba2N9jHc3hNPrRuBbOf6Km
	0NSRn2yNqGx07x82cwUIBKNZ0z1z/4pNtTPiZz+gZygFE1RU/GHu26S7bO8hMZ3L
X-Gm-Gg: Acq92OHm5J3qYiG+AHPru3WOBkTxaO/P622u1urtzGk3BOzU8s4EsF/mbRs98MX0HrZ
	XGGZ6fJt1VV/F4RxDNVGst1aejA1WxfX6FXL4QXSIdAwRC/2G5HBgGbfN8taXWy9zhUsy0iOFAM
	z9Ld57WMyVVyJowPeqS5B3Dj9ldI0lQ27d/9WDgqXHsg6Pc07gha1A3Lv17DFRniXqhzGGgH6Dm
	ZAxudIYzZD9qxY9GOvoYAkXs8QL90X/8sYKinDj1CW66MrAsxuxPJofBCE48YWXDNHvqQA1TyVa
	pNNjOJoW8D4Q0l1vkVnb321SiNMIVxikp5XqsIeZ2dv4aBo38AWKWLrCYr8csnR/s4xnlrvo3jD
	N+TcNNC7NOjpZCYln9hgRXWAHEM9G7+JzjmQcYOgHor563kgn7Hm+2Lt2mvINFVNmjMeDw/UG0k
	VVwHQBIHXZPZ03bwD5czluBaEmQm8rZKqKVukmPdYMVF0d2vIgK1rFodAXL0vx
X-Received: by 2002:a05:6820:990:b0:696:924d:2956 with SMTP id 006d021491bc7-69c942daedcmr12663629eaf.14.1779184150401;
        Tue, 19 May 2026 02:49:10 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d045e6fb1sm6482375eaf.2.2026.05.19.02.49.09
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:49:10 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dbcb467f2bso3313891a34.3
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 02:49:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9PjIziJwlgJb72JcUKZ3mhSUMAbVpO53yCNE92gRmoordzmN3cN6nsU/7/X2OkIG5ARxUFGkDRLDE=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8993-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,infradead.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[49];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pwm,dt,netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BE1E857BA44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

