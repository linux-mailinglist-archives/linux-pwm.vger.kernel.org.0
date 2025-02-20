Return-Path: <linux-pwm+bounces-4962-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2AA3E11A
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 17:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3EF1885208
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Feb 2025 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642B20B81B;
	Thu, 20 Feb 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYdaRJGZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F142080CE;
	Thu, 20 Feb 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740069764; cv=none; b=MrzYym6OPxqhNei0ESvzXXJo370NC/sY+V5N1FcdLtVLJPMerauVoBDRgW72ezb0MtXjN9+SKfIwESw/x6DXspkhPA1tqXp9wBBbsnZpce31gBhdxvDYRQq/Nevru+OOHxA3SFuKPt2bMJNFwKwW7MDs8HlBdPMpLKoVx0WMLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740069764; c=relaxed/simple;
	bh=Spb5DN7Z957auhFhK10W01ysEwluGPWuq85ZNm+0g8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRaJWnwcmyNtXb6pYulYcoQASv7lOWt6gCaA1xy8QVIv3uTqbZZ6nyY8pPtH/+H3Mc4yXqDkGvMUVn3idgRd7M6wFZYdpZSzaA2c7aKabLpJJ5UeSlzskqKii4iMFeXGr73S8Z8HgCnzVJ54G5JFkN3yUlgsFPfNmaPDB2avoOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYdaRJGZ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f286b5281so626584f8f.1;
        Thu, 20 Feb 2025 08:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740069760; x=1740674560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Spb5DN7Z957auhFhK10W01ysEwluGPWuq85ZNm+0g8Q=;
        b=MYdaRJGZsSkBYFyIv1K9n8TID32TOZf/g4ZBhc2NIFwK/8mzXERgeVIDegV7fLU+Jc
         /X82C92mmO0sVJn+EigA3emwOJ6V90oYRNvb3LznOvqTsKRAca0gRaPMp2m3PZPysTUE
         HFwwUSMx8g3aYgHMaCbIQrdPgPvMqp9E8A6/8jnqM9PK/NCtP2CnJ1oI3Xf3hqBso6iv
         3HwxJiNls9HlVvZaumUX8EE9lp3U4fL/VakaUMCADorLvr1zV7FXdrFLUzT/j+Sd8PVe
         51p/bfB3FNHqdiEJwa3xn8cX8z2EE8PWHb63hpy8TImISaSMIXuDt9pjK0STf8UWsh1w
         3hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740069760; x=1740674560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Spb5DN7Z957auhFhK10W01ysEwluGPWuq85ZNm+0g8Q=;
        b=j/F6tyPPO5fe/qtDARAmzYXSz85ZOaRTglO8rcnIvD6v6nBXjrRGlSZYFzjDT+2Jjb
         dEY4s6ru/oF+oUZrFbrFmsbd4ti6kgjvh8S27T28GNi9gGC7jRlJrv4jooPJVqvVr4XF
         Zw7jdVB1hp3102cCfkXtqNQ4OifGdMtxcoNDOyxfWUz3LPljIbJjWoza7WxqZLfc8Qwm
         mj5QJAfiURI/TsvCkQr0Wx2ZODrmDm94482s2d6npbSB7Xhb1BQ4RcE/9XjRwfoHFHEJ
         TnYldnPyFtx+kwArZsUMahZ5qeJ43LvHvsynO4cdEjIeQ1L6B0SPpiGig8Vmck0TwIYR
         5J1A==
X-Forwarded-Encrypted: i=1; AJvYcCUg/f69nx39ABXT3O5kZPCfz0uFAptKsBq8QSKV5rl1u5bTY7T50NCFgW+0iwMa5b57W6yPOkUfBya7@vger.kernel.org, AJvYcCXtGyrGbEjloscMeX8oXZER9V3uDiAEeR0v2Xe0s0+TTCqXYF1koGc9ydyshFPGBgbAFmak87K5YI4q@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhjBMzfK40C2AwkYh0bEosbnP1WvcJw+u0ASw89qb8Igtnozb
	K4qmxhFxcBoNmCewqMeazgjFVXgrwEkIFt99Zuo1BRcoZF/ix6u8Uxq91ZafBHc=
X-Gm-Gg: ASbGncs7PuRidNAphBIzowtip7BhKs2TzXe1nzzktKFZ6ErWTLAdIiJakskfy/R81on
	KhdoZtXE0Y8niZEV1YZDZfgcLi7KqGAEYGdPOfs/R7FannrsMoTT1gNShixfnmV7OCfg4IpnAxX
	TQAdmNyiDJjXMPFwR1dlLz6XSt/ynfZUkbnPlY6pFUSG+P66By+ttDFilYtB2gMjmbkD6HmSi0b
	y8rPHyACIeIrEeXaFcpr2oa75Y6Y2NBBEAbfD0c2pO4xFQbtsIqgTyzaOLherSi+zActVDOPxri
	ClPfVM7fnWSYaz865VtSri1Cb81MUWmh1oFTJhVMIQH3Gy0CFhHp2wf96NBQ2+5roWU=
X-Google-Smtp-Source: AGHT+IHKAPnHG28kS2PXP8ZMEI3ZDWU7Yq8EPs8z2/DhkZ5Cc4K6VvdHC46lFrkP+dx+zXRT0tV7pg==
X-Received: by 2002:a05:6000:4025:b0:38f:4176:7c25 with SMTP id ffacd0b85a97d-38f41768063mr14903972f8f.2.1740069760495;
        Thu, 20 Feb 2025 08:42:40 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm21139863f8f.72.2025.02.20.08.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 08:42:40 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Aleksandr Shubin <privatesub2@gmail.com>
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Philipp Zabel <p.zabel@pengutronix.de>, Cheo Fusi <fusibrandon13@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Thu, 20 Feb 2025 17:42:38 +0100
Message-ID: <3688166.hdfAi7Kttb@jernej-laptop>
In-Reply-To: <20250213094018.134081-4-privatesub2@gmail.com>
References:
 <20250213094018.134081-1-privatesub2@gmail.com>
 <20250213094018.134081-4-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 13. februar 2025 ob 10:40:14 Srednjeevropski standardni =
=C4=8Das je Aleksandr Shubin napisal(a):
> D1 and T113s contain a pwm controller with 8 channels.
> This controller is supported by the sun20i-pwm driver.
>=20
> Add a device tree node for it.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



