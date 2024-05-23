Return-Path: <linux-pwm+bounces-2224-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47998CCAB5
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 04:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B711C2110A
	for <lists+linux-pwm@lfdr.de>; Thu, 23 May 2024 02:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C704D5227;
	Thu, 23 May 2024 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE5o4wD8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5C4690;
	Thu, 23 May 2024 02:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431180; cv=none; b=hQktHYrtd7rfVfoB2kuvEOET2TqJ+D3D/x9jhDlEcmi1DYW8pkosW3q7LuoV4k7m/k/5uZB4cKOc31Sp2pk55Ll33FFzPlQRwg8ExHkx5BEE69W/zJ+Vr69ZA20MWVRG0KAp/Fyjb7dO7VNvYtFlJ5n2L4rY8P0UTn8daOsrbWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431180; c=relaxed/simple;
	bh=6pXbAmaEPZXIqK0WH+L/c24D/aC57W7K7SWkfWovUKE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UqY4DGTtqBkfsjYVDjYX5jcb3E9y+dq6DBes8fsCBx1w5t9Dsid8qmnlJzSrxHawyT1Ai+WRArv+XKj3oefeJZOFDzQc82hdUkrMS1wB9x08bNV93k3b+8shQLhDNHO+hk3nyPgyZe0dFpOreK4KmylmaGJFW3l3aOpUxrSFpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE5o4wD8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-61bee45d035so59634247b3.1;
        Wed, 22 May 2024 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716431178; x=1717035978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=14MDcznVSAxWvh6NcnmWmS1Snv6rWvGAAp6hU32730s=;
        b=hE5o4wD8q4ZYtnrFPRC9Ps4qdDIbAiTCQ7QhyxkFEGebPmI9SCqjz2ZugckD87fqDH
         9ZLLhO1dadjIx1mo1bTM4EFe/e65sAxmVCP52Qax8R7PDZHvG2suxzx5u3heXbR56lT6
         ooXydp92qjue20mYXzfxAeFe1IEMOK6naZHYakWKoo3SwyyptYX6/tpbjRO2Oky0e4S9
         gtPYAcI9DnmYM0Ytf8QsCTdFHD5axHrvQ31AZs0qwfTddKpAPOcPfEloMCN905KFMiYb
         ZVK3MKjILl/YNZyMjUmWWKfIPvz3dQQxM0uF7/KWkjqNshM2VME6ebUtcc32UZt1Uo5l
         VYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716431178; x=1717035978;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14MDcznVSAxWvh6NcnmWmS1Snv6rWvGAAp6hU32730s=;
        b=Rxgywjfl8pPlTfgmAteRnl35tPTe/Fhzgu1p5/1Trfyz9dUDzsFbEg36ZxoYfcmoU6
         VVXczSrebhx6fnrbkuNW7P3CSLTykfZU2zbgvRRrIQa3GhwvTV/cr8XG3hPVXLdwI3Gz
         ACaXbPs6PwKGC0GO0QRm5oTfG5YMtOoqPucuiiT08PQ39mssi4JlxawBFGnFXYmfE83E
         f10iVDk1Wgt/EQ12r3ULSZ1qaqhssaEvHG/S1Vfl/nCFMctwgJCehPrD0VT7MXhrgc2R
         moO8H6T71026ux062vT9PO8NK0lfSBt6rnSiENDyyW6D2Voj2hZ6EqQigXV7CoGfktKu
         K0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUAsZyk86YLiNThbpryfUtmSGgw9xgjij6gvsjiy6hD4AoMrW6BCbAMq3SeoaqUsyBNXZdb6N/8I3KIq97Av6QaA1tA+1bGEk3GMBGl+H1C1QsDzWXnMJ0K5s5pHQBmV28/Hch/83GQoJtXAqDjrNNqeXQrjymjLlWKOt8GgAYuXSUOCw==
X-Gm-Message-State: AOJu0Yx7x0MhGISL1tekMKjr8oOzzqnQavc2dsdXE8JBiXVm4+XrBCo7
	WXfIjMsuIkB2EeyqSHCKmD73DYnwPasascVIb6iw4DwruJpEwncu/Re+//fCrcPDaTsocBZWKJx
	H4qs16NrYnsQ99o7H46JExNPhrns=
X-Google-Smtp-Source: AGHT+IEzZ3d/y1htQ50ghcV3RsJuT9Nmb23jVS0kW1Opjrk11BX2iM4RFV1kES07q4M/y7BLnPYzixD6kqgZrYjmEI8=
X-Received: by 2002:a0d:e64c:0:b0:627:dd88:5f1a with SMTP id
 00721157ae682-627e46cf82amr36209267b3.21.1716431178362; Wed, 22 May 2024
 19:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?44GN44GP44Gh44KD44KT44GV44KT?= <kikuchan98@gmail.com>
Date: Thu, 23 May 2024 11:26:07 +0900
Message-ID: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
To: privatesub2@gmail.com
Cc: aou@eecs.berkeley.edu, bigunclemax@gmail.com, conor+dt@kernel.org, 
	contact@jookia.org, devicetree@vger.kernel.org, fusibrandon13@gmail.com, 
	jernej.skrabec@gmail.com, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, mkl@pengutronix.de, p.zabel@pengutronix.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	samuel@sholland.org, ukleinek@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

Hello Aleksandr,

I had coincidentally developed a PWM driver for the device.
Based on my experience, I find that dynamically changing the coupled
DIV_M value is quite complex.
The current approach has limitations, especially with resolution
changes, which can be unpredictable for users. For example:

  1. Enabling channel A automatically selects DIV_M.
  2. Enabling coupled channel B with a specific period may result in
poor resolution for channel B, as the DIV_M value depends on the
period of channel A.
  3. If channel B is enabled first, channel A may not be enabled if
its period doesn't fit the DIV_M range selected by channel B.

Additionally, using APB as a clock source for the channels would
further complicate the process.

To simplify this, I suggest (maybe for the future) specifying these
values directly in the Device Tree like this:
```
allwinner,pwm-coupled-channel-clock-sources="hosc", "apb", "hosc";
allwinner,pwm-coupled-channel-clock-prescales=<0>, <3>, <8>;
```
This would delegate the complexity to the DT, making the resolution
predictable for users.
As a bonus, it introduces a way to select clock sources for each
coupled channels.

For the meantime, I think it is enough to use fixed "hosc" and <0> for
regular use.

Looking forward to your thoughts.

Best regards,
kikuchan.

