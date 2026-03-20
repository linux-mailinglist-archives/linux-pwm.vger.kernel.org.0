Return-Path: <linux-pwm+bounces-8310-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEXGGPlTvWlr8gIAu9opvQ
	(envelope-from <linux-pwm+bounces-8310-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 15:04:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B52DB89B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 15:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C48330216E3
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 14:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47C3C13E1;
	Fri, 20 Mar 2026 14:01:09 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C53C061E
	for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015268; cv=none; b=cXhZLnV5Bq1TlofIkmeiPLPuIbQdhfj86n1gYAaWxub3ZKgD1zyUvrgftbdvLx8RsDBPYeWedHHn0m6m0684EEVmhUKOC0Dq2gJv5wUjlUbkhkdUNY2pA6S7icNcrpdGZUPUVX1eMaXqCoxb0fs+1Bf5ioYe4savdbjNmpp1yXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015268; c=relaxed/simple;
	bh=Nx8bQBs95SJZiGV9sxDUOjb6cqnHHMShwIEg031kToo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6uvxxE8b7CEpQiug4e4mT9jo6Hu98Vt9hKOITlhek31EtWcJN46q2DB/cE1uwlRzCZ+VNDYaWjLBIH7UoG295X0C/a3WuptSk7VIXzeOLKOObXnaD8zVT60utKAH79uPQL2vAzQx659kcx44eWQG43rHf3pHexKdI9y9t7yUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-467d9ca391cso739164b6e.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 07:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015265; x=1774620065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txsLO2jkdNhN6oBkuArfXNgiBSygoSMNA3GUMB3p1q0=;
        b=RZBcFvs2iUPvzFDbg0JIFVIT3vtsUyPoQ6NvPjy4bO2trUybrmyptEA9Aw6uX76pND
         yy+d67O0wmxZ8ZRhTYEk+ZETDzJLTXgXC9tD3OsOhlVCXRtvNudosRLOenQFGCjkf962
         BZDzSGWqgqniXT95Rc8nvuRPoKRVO5vCtpAerVVrjrzI51hTPHvBBPvVkJgTxwk94XYi
         DOCH06CLB8hBZ50UMSrp6H7if955RKWEd5Lvb+3lHuI+TSqgagiBrxoYv+/6WTuxoGpl
         Gr+cGuCQoKG5F5HDpCoh79qqiLfPRP+YVp1mFlXLn52ukVX5xE39e/2Obl4+Ox/SoeVW
         zcpw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHwp3D90bhToRJeoTBuGruLRIPkujbdxJYPr0UPuZX9giEDYlDs+3beYUK+W7Tci9XYBwPxpcwfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzjpG1pvZwHOkWrb88C1FAfH7VgMT2ZypPIYmoMlsdSiTgZ1U
	u8uuVNxGJP9XG7XYYvSe9q9lRhbKgOcV9fI40jCTKony88Wh/IqlNHuLx8yHEgZD
X-Gm-Gg: ATEYQzw0e4bzRpOzLQ61QTfw84WO8iQRY8eHxa2u12xP2E6J+BeLiwp5tU7rMZg8ZOb
	suaih5JytHiXU6EaxV8LAr78DB6FWZLudgu8SZ/wEpWLSqI4rwpuFTv+Nksx9aIeL7ZZYN+6iRf
	45Mzag/lj3/EgUiak0uye1ngcv3kGur8wfuY/b4EXqX/+HAzyMYnDC+EfOEftvzx+vkNxugSuyV
	grGzW5FvVGHH7mBQiqOeol+fIVFz5ZbptIvuP0idTkZJalDGN/mqhgDo7f34MI4JGRBBJ1RUgk9
	V7txN9ujf8+fshz1r/da+FeHNFOxyv2ak42nDCJw7OV8POnHxvGV0pHSy2b8ESOSfAOJBbAnxbs
	zVYAq3r1FQxWPhuVy7KAwYasXlSSPSxfka4W6IaCGMsbAg7PursQi6odrHUXQm3cmF3NbCLAdxF
	kzYbJxXOiEOLA4At5/KabFO50t6Vfe+vlTNbgeNsPFWH7UM9A/SkxiG1OvYqTNImzR8tFL4T79J
	WdtZaAoDJ8Y1rxArPne65kpP0tyVd1nfKOT5VDtXq9Rcoy5lKKC9QxN5ZCdOL+pJfcha6Vn7A==
X-Received: by 2002:a05:6808:6702:b0:467:ca8:c396 with SMTP id 5614622812f47-467e5d34590mr1805095b6e.9.1774015263974;
        Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com. [209.85.210.46])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7a96c3asm1432904b6e.0.2026.03.20.07.01.03
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7851e2cc4so1880854a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 20 Mar 2026 07:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAbtKcmHINyVnbH85GRDlO82qHfNmXLA+oIHVgnKgfNNcNcluTEhgqUz50ZJiE0qWsoWzA+OsILcg=@vger.kernel.org
X-Received: by 2002:a05:6830:67c5:b0:7d7:d15a:ce8e with SMTP id
 46e09a7af769-7d7eb04feffmr2015751a34.32.1774015263260; Fri, 20 Mar 2026
 07:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 20 Mar 2026 10:00:26 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
X-Gm-Features: AaiRm53Q86Nf9dVOSTKn0cYEE4xmDvp3jUYoCfYFj-SX9hFNk_weUYFVfwHr6Ok
Message-ID: <CAEg-Je9b1VujkHCVdXowQs+BXA0+DL=6sdoP0wuSYpau4T31XQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Initial Apple silicon M3 device trees and dt-bindings
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linusw@kernel.org>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Michael Reeves <michael.reeves077@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8310-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gompa.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neal@gompa.dev,linux-pwm@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.595];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gompa.dev:email,jannau.net:email]
X-Rspamd-Queue-Id: 5E6B52DB89B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 8:23=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> Changes for the interrupt controller were sent separately in [1] and are
> picked up and in linux-next. The device trees pass make dtbs_check with
> the apple,aic2 dt-bindings change from that series.
>
> Link: https://lore.kernel.org/asahi/20260223-irq-apple-aic3-v3-0-2b732807=
6b8d@jannau.net/ [1]
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Janne Grunau (9):
>       dt-bindings: arm: cpus: Add Apple M3 CPU core compatibles
>       dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible
>       dt-bindings: power: apple,pmgr-pwrstate: Add t8122 compatible
>       dt-bindings: watchdog: apple,wdt: Add t8122 compatible
>       dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
>       dt-bindings: i2c: apple,i2c: Add t8122 compatible
>       dt-bindings: pwm: apple,s5l-fpwm: Add t8122 compatible
>       dt-bindings: arm: apple: Add M3 based devices
>       arm64: dts: apple: Initial t8122 (M3) device trees
>
>  Documentation/devicetree/bindings/arm/apple.yaml   |   18 +
>  .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |    4 +-
>  Documentation/devicetree/bindings/arm/cpus.yaml    |    2 +
>  .../devicetree/bindings/i2c/apple,i2c.yaml         |    4 +-
>  .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |    4 +-
>  .../bindings/power/apple,pmgr-pwrstate.yaml        |    4 +-
>  .../devicetree/bindings/pwm/apple,s5l-fpwm.yaml    |    1 +
>  .../devicetree/bindings/watchdog/apple,wdt.yaml    |    4 +-
>  arch/arm64/boot/dts/apple/Makefile                 |    5 +
>  arch/arm64/boot/dts/apple/t8122-j433.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j434.dts           |   19 +
>  arch/arm64/boot/dts/apple/t8122-j504.dts           |   37 +
>  arch/arm64/boot/dts/apple/t8122-j613.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-j615.dts           |   35 +
>  arch/arm64/boot/dts/apple/t8122-jxxx.dtsi          |   48 +
>  arch/arm64/boot/dts/apple/t8122-pmgr.dtsi          | 1149 ++++++++++++++=
++++++
>  arch/arm64/boot/dts/apple/t8122-usbpd-i2c.dtsi     |   32 +
>  arch/arm64/boot/dts/apple/t8122.dtsi               |  444 ++++++++
>  18 files changed, 1859 insertions(+), 5 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260319-apple-m3-initial-devicetrees-5c546ad977a2
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

