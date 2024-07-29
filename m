Return-Path: <linux-pwm+bounces-2932-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293193FD9A
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 20:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EC6B20AF7
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FA1862B7;
	Mon, 29 Jul 2024 18:42:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE28061C;
	Mon, 29 Jul 2024 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278536; cv=none; b=X2oHCy0955CcY3a+wCiIPyTcp37wa34NKfptaqNQSr4ZuEYGLizcN2gN5sHryqvxbDNEeM7/dxSVkGo+rOUNkrFzltPSQRfu+2HTMBD1x6JyJUxZHnUus2Z9jPShOxmNscNy1TJp9K4L+kue4jdiY+XvyPQUD2xlpRMf94+TFRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278536; c=relaxed/simple;
	bh=Wnx0qvjxspruIcf4/Y9rK2byAG2Z2O9VS8esrKBtiNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R15J9BdzMDc4cWGM/ibWWjjs5KZorT8Orpxun74M/g7bfUILg+KBj9EvZHRf9+PdFo32nEYF2R8++AXH7GLe4cwp9xizHEaK8mj5fb/8NvdtcoXSDaYuZC/Cvxj9Rebkwem8gg1pQSBDPRSi69lvSKgx93scxMfG6wUoPk3+/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-66ca5e8cc51so26164627b3.1;
        Mon, 29 Jul 2024 11:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722278532; x=1722883332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR/4A7+nr/LL0s6VEXDKmBKWbVdIcV+/2Qu7ZjRDS6k=;
        b=FKvBLOhVoiK+CzArYnZzZn0ZUNy4YgbNWeUcyj8ybFIQ5wp6EONBCqETVHlJbafFhs
         ufoW4bqoXA8cfbmC/DQYrkobtn282aju+Ly7S5Eg32CSGNz735Q9Uv5XfK3LpYS6MDUk
         9o0aExCMx5iCZLGGZH0i9TG7uvQhvQGKPNqSxroto9TfQuD6IyZvHf/WejATcCc3ifC5
         BQqL79ZGHw2I2gpnAED15bmOqsApxJ6EX+g+LQWepTRYB9H+1eFOTSThGu9d8meOYCzx
         xwkxYuMBl/9jgZmSQLoa2PGSGo0geV0ii2J8PjlVwswj4C82gcYpcEMU9nK6XYcH3EkM
         Ym9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMvK31qLhYU75Sh3f4y6/2FCEVOWqeNtaxZdh0/deGRUf08qZgTnj73ehIfFtQwecpZ6mS2ekb+DIrsxNginBn13huGmj5pAn30UqH2dbcNK6HNTTZY8L8dyrLxplzOyMSrYNPAGZmeFDVRbHYiWDdXxrheHxbOQ6X5N5cBrQQf3x2ug==
X-Gm-Message-State: AOJu0YwLTso9X2c401ai/jARMKia8qQ7YcrOF8GlkCj9F0vtU7g6kVuZ
	Ol9LCLs/O0XFWyA3xLysYL9/G+9cpC1X5uEXLLZKLaswWlp5mVk/TsJUgcSy
X-Google-Smtp-Source: AGHT+IHEPN06BBKoLvj9j2AFlxiWDvA70usQNaN/MzyE4VxR9DP/YFcYHZfSfPx/8fig3/NWaz8l1g==
X-Received: by 2002:a05:690c:6d08:b0:66a:8ce9:b1c7 with SMTP id 00721157ae682-67a0a136022mr116737847b3.37.1722278532044;
        Mon, 29 Jul 2024 11:42:12 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024905sm21917227b3.76.2024.07.29.11.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:42:11 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6634f0afe05so26415257b3.0;
        Mon, 29 Jul 2024 11:42:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXElx/qBNOUXYUyEu3gUknP2VOlXHw9mLbOhnK80aOlttJNPyhP6GZwoN2DMb9jPGGJ4B2Q6devkWYtn8GKFXk2LxHEUnLzDFInbMTrYJFFfgDtDrjpvLsLGCy5jRWBbGWYi2Ey6pRb6hWN8Do3y/nwe0G1hsMQVzXwT6rhtHSxNBDScA==
X-Received: by 2002:a0d:d007:0:b0:673:1ac6:4be0 with SMTP id
 00721157ae682-67a0a3231d1mr94499717b3.44.1722278531101; Mon, 29 Jul 2024
 11:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725193803.14130-4-wsa+renesas@sang-engineering.com> <20240725193803.14130-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240725193803.14130-6-wsa+renesas@sang-engineering.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jul 2024 20:41:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX8jYDeKfw9qtPGVauM8eUZ32j93Dvaqa25kf=AAeG6Zw@mail.gmail.com>
Message-ID: <CAMuHMdX8jYDeKfw9qtPGVauM8eUZ32j93Dvaqa25kf=AAeG6Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pwm: renesas,tpu: Add r8a779h0 support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:38=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4M (R8A779H0) SoC.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

