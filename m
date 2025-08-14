Return-Path: <linux-pwm+bounces-7061-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EEBB26F01
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC01A5A837A
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D122FAF8;
	Thu, 14 Aug 2025 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLm6nyJ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F6F31984B;
	Thu, 14 Aug 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196559; cv=none; b=KPcF/RxvjnM9mpXR7/sa8c8g06s/KYHkHwxt+DaVbpvaKMJVy0dc7lpPgVWJH1vvtFFy3EYOmeNxhjejZyGxFdmAi5qngX27E6aEtybgaQrxFLm9KkZVuYtnJ0x30Gc7fkOW8+XLpv7Y3nKclgNSh16bBejbxq4UTHaoZ5+39UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196559; c=relaxed/simple;
	bh=oFoTevpJTkFC3fnPkHq5WaRUhn9wdzE1Nk7qHgaKBHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Un+ZLK4JQjo236yeh56QBa+EW2n7j5vTFUR3q6G+TbfATWiBWYmhhLXLkTwThXaS9Egn5tIH7iVkkZAJ1lfCtHmcH2Ify2P1D2toja4mFIJGyiwjHNCioIssFDuJJ46yC//Fiv4Z/fE9166W/K+bQypvi3UhSWI1CDlgQ5kmz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLm6nyJ6; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso793730b3a.3;
        Thu, 14 Aug 2025 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755196557; x=1755801357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJt/hcAMZ2yC+7PBLbpVyeoi2vS5Vy+duo50bI9bdV8=;
        b=MLm6nyJ6KW8O7NRsS1xYgMlgzxBdCe+doD4YLtXX+JNh1ImEoaPnbvMEmumoLBPnJJ
         KiFiVHSnT10uRU4GkpqEvJndzmljP6sneadVVSqjf6hHV3hihCsyl8mqwPdd4T3LK1k9
         jwlKc5CdNA1xyQDV8tRGTKq3NFv66GYGj5qKvqyA9/StyqzkLCsnODoLWOO4QxiBXo7a
         DqyUixtRAwjMYEW1aTGXLSlj23MkDOP/HliJfXsK80fHGOwFAzLWAicj56FFGmsSxaXZ
         S3vy3kuULBT99ypBfxtrZWjhkXyJn32F6JT63YH6j5VfP0UDLXv4ihQN5586JGV3/muj
         qRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755196557; x=1755801357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJt/hcAMZ2yC+7PBLbpVyeoi2vS5Vy+duo50bI9bdV8=;
        b=YHjZMcdFvMaNnCuWrKwca3EWAROlX0/hYwN81fhOwG5vSc0iURtqosfWxOyiY4A4hs
         0j0wKw4+y/usDipz9eMlZihexbnB1Icgdkizozvgc2YdKLeEsCsNZAc1Omlt52XsYIW2
         ENeh61xRspgJQbongr2mPKgmF7CIdyQpCV4c2bDdVOenq4pKxyAAozxGuNFHJv7IutqY
         /9pdENj975SLSxEa0BCSvyuE5wZHbTnUbEtQOhwm7sfARdJYOC1cWn8KjwBwVbXsQLSP
         0PJkoRcAofKKi7XGDlWp1l5Azu719bAgfgDkoxkFTASUWyMustJQainDKFAgI5YexzEE
         KS6A==
X-Forwarded-Encrypted: i=1; AJvYcCUYxtyIfpSDK8OZzzF4KJEPcUFnJZThJLwOMmbftzPWMsaN3qb36Xx7IXRZNQOgS52ctRuNmg+OYxfT@vger.kernel.org, AJvYcCVIa2YskxUevOsawJ2pIlpHWCACV6fLJxYaTnln1loPNMOzxujMuZdTW6HQ7IcXItfZJDld26Nf6sfKdv4=@vger.kernel.org, AJvYcCVsyp1Bk6RcNaG6R3SerCpn/W8m12YmfNcQ6NZYuHbGDMHaT8o06GogXn/F3eJPNwuGOfj0aVY0x3VB@vger.kernel.org, AJvYcCW5z8Dq/7E7A8WYupuWuU1okaO9HuK0ALhTZKa0hgHcd+IjENcdU021+h9sVYNzgIg7AJp5YmZpKsSBAMI=@vger.kernel.org, AJvYcCWg1awFdJuB42m7U/gBV9Bet6SsW8scCeZi2CGwoEFJWj4ztr+LPt3ubuso7t8zmEbLriMVONm1lVKC@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gcsjI2kSvgu6vyv0QHtvz3c5LkIE4FPP2E4JBnJcz65xMIhc
	y3cNrEMkHWit4zqws485oRlZcn434BpyDfDER6yDm+sTWZUE4QC1Pnf4oyDNnQ==
X-Gm-Gg: ASbGncthaXlYigHFUkOtislDlGVSHDJ5/vQh4pGaiy2/bQPFk5DJEfJ6UGuUN/Yl00t
	q2Tpx9YSYW/bqwE07dt4E2Ns//iYmzp82m+Oktt19l6tdpWpfr8ekTO+X07KhW8SuCZPaNFcCYr
	7y2sIlY/PZWD40WnOf1YRvnPoUb/fHpUmw7hsgZev1F10tziQqd2655foPqulN+YtblpE+d6SRT
	MxvPlfh2lcNSlkf8tf4ha+cn/zsztfXhhebU0NUI/HrL88gtzWzQSMYEWmpxf5RKyXdQd7Khdjp
	CWezE3+tBz7rT9Fh5trgqL93CNJo4hkNq7cE3id/DvL3N1A/6WWsUDHSolH37WjSk89UeZV3tSZ
	dY6sjFKQ3xLGL7nN6dXfnyrQlaHfSJkztZg==
X-Google-Smtp-Source: AGHT+IFTQsaL27wAfrPNbpedIL9oHlFrTHdo6Z1kKN/DyNl5f8XhqHluOPZCfB1ZEEe26gStm1qrjg==
X-Received: by 2002:a05:6a20:12c2:b0:240:2265:acba with SMTP id adf61e73a8af0-240bd25247amr6795783637.42.1755196556706;
        Thu, 14 Aug 2025 11:35:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bd82:9778:4ed6:7372])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm25052379a12.40.2025.08.14.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 11:35:56 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:35:53 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info, 
	peter.ujfalusi@gmail.com, robh@kernel.org, krzk+dt@kernel.org, lgirdwood@gmail.com, 
	tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org, ukleinek@kernel.org, 
	broonie@kernel.org, gregkh@linuxfoundation.org, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2 3/9] input: dt-bindings: ti,twl4030-keypad: convert to
 DT schema
Message-ID: <ziwtdg4elih73nkguilamjh4gfgg76t2evwvnj6pscywvfexyc@abvlmgoij3us>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
 <20250814132129.138943-4-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814132129.138943-4-jihed.chaibi.dev@gmail.com>

On Thu, Aug 14, 2025 at 03:21:23PM +0200, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL4030 keypad module
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation by inheriting from the matrix-keymap schema.
> 
> Changes in v2:
> Simplified the description field by removing redundant '|'
> as it does not affect formatting in this context.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../bindings/input/ti,twl4030-keypad.yaml     | 44 +++++++++++++++++++
>  .../bindings/input/twl4030-keypad.txt         | 27 ------------
>  2 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
>  delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
> new file mode 100644
> index 000000000..2efc88b89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/ti,twl4030-keypad.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL4030-family Keypad Controller
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description:
> +  TWL4030's Keypad controller is used to interface a SoC with a matrix-type
> +  keypad device. The keypad controller supports multiple row and column lines.
> +  A key can be placed at each intersection of a unique row and a unique column.
> +  The keypad controller can sense a key-press and key-release and report the
> +  event using a interrupt to the cpu.
> +
> +allOf:
> +  - $ref: matrix-keymap.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,twl4030-keypad
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - keypad,num-rows
> +  - keypad,num-columns

I wonder if "linux,keymap" should not be made required as well... 

Thanks.

-- 
Dmitry

