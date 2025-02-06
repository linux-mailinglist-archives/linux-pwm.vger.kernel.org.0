Return-Path: <linux-pwm+bounces-4795-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417AA29F45
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 04:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4004B1887394
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 03:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F59514A4DF;
	Thu,  6 Feb 2025 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjmKLg8Z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E7148850;
	Thu,  6 Feb 2025 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811662; cv=none; b=pw2kjoF5gFlU8mK/TqEMDhvNwquVVzMC+Bhqp0oD74q+BnFEBeAJ7CjzcmI45RnyvTWxN1f9GUSbKAcE9Cmiuaw2clIVrJsBCOi8Vs5zkxGLqF+2okIazyVTBUAOkO5a7SYNRVjWwmhbZ7JSsJ7IecW2suLc1O2P4P6HZMUxLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811662; c=relaxed/simple;
	bh=9Pca+vxytayyUNgXVOPiZeDXZT05/oLDgxAGxD3VM20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eCOiSRvXz2uZ3jIZY7CU3XLGNTRbZK3YcJ4fsNeMyijJoNGKOWRZ0LJJFXNYsmWnEx72WVvd83A9POdaxR73H7R70vrFdG9sBJ1HvmXt7D082p4Esf72/8Ijq9XESDXLWmTqG17OmFBhLx/9NRKzBhykJOn04TP1y9HIQj+Hssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjmKLg8Z; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9da2a7004so586993a91.0;
        Wed, 05 Feb 2025 19:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738811660; x=1739416460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjTgC8sFuCrTKqN6M1DhU5LdbzkuYXecDq/EnRQ4HOI=;
        b=jjmKLg8ZT6VI7XyKmnMNhqPljM35ajtdPPmGRp91kxzc9IKG39ssiJbeid0lxAEM/c
         yPk3WiGqMAoGkDjZwQrUpTTZWwGtFLafWn/5yDUCiYVZVwPRkNwOH6uQaBSB4rTlTvv7
         QQnp69D45Q5XeBdXGMGV6+uKCrmRevMeuK6pToGJQ2xjllLvZ6aIhQZXpBNrosU1ZHi1
         lTz89fzQIb0LZUfTEY23IB4Z2aL86YAfWifSHous1vImn5M90XsoRvSRs+a1xq175mN8
         5Vob6xrH2A3IHyPzjTM3uHqHC1FSMLxllwp6T7+/DAoj7bcLu2HJmUEHSx+N/kKLaAw4
         p/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811660; x=1739416460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjTgC8sFuCrTKqN6M1DhU5LdbzkuYXecDq/EnRQ4HOI=;
        b=eqy/ca+8Bu3EcFzFDijdKl+S6cXGLCsWiDmDYdY6f+ivGuKxkg0ac8reRonEaprS6U
         AYqXcz+daARG17FrPvMY2ywpBuFgy6WYk+kY2cfdkyXa4S0AI57H3qfLt/zGXhSueex0
         UZ8rnhjf6gRzJ2kWb3ml7veMfVRCfsYV+2wtsC9OEle9/O17dSDVGtroyhi1RkbnIWtW
         aIsS8GhsjVnu8z12JmlSU60yK3KlpQxLn5Ke7q4p/oti0rGWSHKWgNaPxD7G6nTnJ2lW
         VCcRc9jzx4pK0CTqeuMRPnJMhCQ4xDbgBKRoLX4PlMM2EZmDfc/4aLc2sODl3f5laH9F
         vHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsG41D6A7rVbse5Y4iis3e+EvsfS6tLA/88QfwewaTJBWbOH00hBYHoFQYRuPjP9C4oeRzLGp6eM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1GaHUtnEt8NpT50/61U8zvuAXtT6i+cDyDbnYdQbMkktK3DU
	3TC1p0dE/h4Es/TrBqsXePZBt955DJ7acASB4jayT9a7V6lsCoa/
X-Gm-Gg: ASbGncs2L/TYU03T2jr+Czy81dqT18Ei410YtHjWtCPDFOVW96aiRIewHTbbbN5XWTz
	TFFF1SXceqxbWsjvTNW/xnd5G5Dd+If2MEwgnlmIYmEGYPypJb1C7AaQFL4HJbxztUCXlvQH5ln
	IrMfIdRsWV/II5JKoXKmaX3Qg/Wrozdd7d6+bLx1+df422jocQBrJnCqPfsqb+BMTV0RZKBbdNL
	d8YFLVLJVa36l8S+wuopJLa4OlK7c/unKYsYeCOir1IlcmNmW+1+/oVJSdplIh2+VUZU4d5mIbS
	pZMJykCv4xDu9un814AqBXqKMsntWgiDJFs8
X-Google-Smtp-Source: AGHT+IENY3fe5W4FV3JynSUF97gWyUG4nKelKONIVZdoCNqwULGauhYSciA8mxtavotlswT6gE19uA==
X-Received: by 2002:a05:6a00:1d81:b0:728:e745:23cd with SMTP id d2e1a72fcca58-730350fe222mr10335170b3a.3.1738811659773;
        Wed, 05 Feb 2025 19:14:19 -0800 (PST)
Received: from localhost.localdomain ([181.192.80.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1623dsm210014b3a.132.2025.02.05.19.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 19:14:19 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: [PATCH v2 0/1] pwm: tiehrpwm: ensures that state.enabled is 
Date: Thu,  6 Feb 2025 00:13:46 -0300
Message-Id: <20250206031347.63700-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <yxolbwr62nfdaeobghokx32fihhh56falxpg4u7kex4is7soam@mfswlo4rbkaq>
References: <yxolbwr62nfdaeobghokx32fihhh56falxpg4u7kex4is7soam@mfswlo4rbkaq>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Uwe.

Thanks for the feedback! It was very constructive for improving the code!

I fixed the points you mentioned and hope you can review v2 of my patch!

Changes in v2:
- Adjusted the indentation reported by checkpatch.pl;
- Added the bitfield header to replace the register bit defines with GEN_MASK 
and FIELD_GET;
- Concentrated the use of clk_get_rate() only once, inside ehrpwm_get_state();
- Added the ehrpwm_get_state() function as part of the driver's fops, directly 
linked to .get_state;
- Now, the activation of clk_prepare_enable() when the pwm is already running 
is done before pwmchip_add(), and runtime_get_sync() after;
- Added comments for each new function;
- Added comments in specific areas of register manipulation, in order to make 
understanding how they work more intuitive;
- Removed unnecessary null pointer checks in functions and also improper 
returns; 
- I improved the commit message, as suggested.

Rafael V. Volkmer (1):
  pwm: tiehrpwm: ensures that state.enabled is synchronized in .probe()

 drivers/pwm/pwm-tiehrpwm.c | 202 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 201 insertions(+), 1 deletion(-)

-- 
2.25.1


