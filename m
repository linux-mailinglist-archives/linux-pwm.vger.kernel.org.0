Return-Path: <linux-pwm+bounces-7592-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDCC3355B
	for <lists+linux-pwm@lfdr.de>; Wed, 05 Nov 2025 00:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBD7E426B2A
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Nov 2025 23:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114BE346E57;
	Tue,  4 Nov 2025 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Nf3h5MV3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4210A345CD4
	for <linux-pwm@vger.kernel.org>; Tue,  4 Nov 2025 23:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762297622; cv=none; b=jKHrT2odpwWrBOSqnMBoQb3zKNuoNd9+BveIms7MXa0qABwBqL/Avxc8JYiQe52CVHx3GtXzA5415xbLl6jYj55vjMktbzKOfQ2hj2y/49lfYukfm9d+5wm3X3imiQ9S/DacgldXY1YSgMl2F8Vixuyi+KitsugVh4z3LqCx4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762297622; c=relaxed/simple;
	bh=CsY4m5s2RMJkD3lvjeOF++mv47u/HIAkSzDbG5YyYFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OqrOwn0NgSjmHGQMh0/4VXm2YZMsfNXQPcYAnN3gZMR3OGoi8ycdxyvpTih1sTzTVYSyXBAuHzD6qQKapBiktgDSctQgIlIO4bzpp2LwwfRueLqNJncrmvXdtJ6vVZ/w7sVNWre9e/ksTN9y6WEoRk1fpjaOCiDozTlOF/8dv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Nf3h5MV3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-782e93932ffso5861135b3a.3
        for <linux-pwm@vger.kernel.org>; Tue, 04 Nov 2025 15:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762297619; x=1762902419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7rOk2SljDe8T4aO8i0PRNva7QDAcRd0Lww0kxlgSZQ=;
        b=Nf3h5MV3kq0+e7RI2TRSY/yX09WXLgN5TtiF3py68fUPDEfoNlXrgqlNGhhPl0Mr1Y
         1kZv/1dvM8+f6I8/yjDAgpDLJdNqO+hP0OJ+OazFUnStjli5WLaQOyaStql/UIhwvLhN
         k/OdXiVBOJRIuxqFr/SD8iepocR4ZlHrIT9o6c3JJ3VT7iYnoMWDfcz7/pDSM1Lnm3rN
         9/0BoBzb3wh74v7q1HV0OokX80JZzSijACcrBU0o3/0D0H1qhufR3ErOQ4afJcH2sMoZ
         vCHsJM1vsBMLuQP/dPF3CpvYrSKwHVtjh0a1tAL5PiqEA14EZYrE+JiZUD+lSmqEzzuQ
         aOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762297619; x=1762902419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7rOk2SljDe8T4aO8i0PRNva7QDAcRd0Lww0kxlgSZQ=;
        b=O+ixSANYDP1kDnJp35WILzLKmOxKf0CyGWhKO1cPrgRHY5MqQMx8JqNJoe3GQKk0NJ
         SVDzdh7sbi9jIqZPp0JRGnUkSIdp8FX4Lhmd2f0Xn2xuXSyquju7TVoneG5tjSdgbnKJ
         HgPWs/wv7521Wib6vW7UiqlHwIQ8+AiJqPVZhqXXET/UJyxqRGkmCZbKFED1E24GyyWZ
         lRsDRsknv2rtX5AGrC5tcEz8B2wMXNFk96PFOavA7BNpTopJK4P9Nh5cZqi0ltVSLupv
         BlWFXNXGWktpZLNBCc94B8fhxLBZuF+lqW5n5L6d8EGXRqAoIp4Ywba3Xjxq8SQtMs23
         jJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUqCV74AodFAvxRrdmvUCM/mTYdH1F6Ky2DeTnT9dtEVY9kvb0LOplMej0jTsbdjgyKxlnzM8OMKCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+kZguT0wrzN/2AtVC5EGcWrW/E5UJaSeH96E4YwvYy/AsAMp
	REaikarNtHA/QIFlVno9rkDOj8gu/Rl0kl7oHQaEvKsxWNbmVMhrqjG3OxTyBFXKBfI=
X-Gm-Gg: ASbGnct0UwbZ8QHOVviIAcTwv1iyBVkmHhm6/Z0kdCxmNo3xqhYIDW2NU0aqABaarS3
	bDn7b4lN11GANl8tmuXWoxal9cNh2k3m7xBjx7VElmA4TkvMe4LB3gPDDqFF33WquJvgh+oltnI
	DOQ4G9DzwQKQWMVMSGUJWAV5R/iYCpbPMQDvTll8zg+sitCBzXt79AqPUJy3JrJz5wcqaWWUul+
	Rfx3pBchQDMHMjf47m3gB5xlMlCDXrdF1md4Lc6hYria/iKUBugRSYnfuZG+wbIKQyhX7CD4E9z
	fhID8aF6mTTqgGHdDTAfla4vBKQtMZxs4t+PepjZ1/rqcexD+b8te2tStgkk1Z2hn69cGPxxoAK
	FjlwEIjPEnlFTImz6d5dgA2F/Tevp8pajWJ/twi7tEpLc2uzmO52VhYBHA5/ydNOOxcikwLZSfg
	==
X-Google-Smtp-Source: AGHT+IGLYp80GBLpwoYMtkxAs/l4LiwUD9QsWZrdQvRIeBfncu8inTEVtgBSRIphFP4oV2r+3SM7DQ==
X-Received: by 2002:a05:6a00:2d92:b0:7a1:68b2:5341 with SMTP id d2e1a72fcca58-7ae1d250dfemr1114563b3a.11.1762297619593;
        Tue, 04 Nov 2025 15:06:59 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd5774c21sm4156649b3a.43.2025.11.04.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:06:59 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: andreas@kemnade.info, Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, 
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-omap@vger.kernel.org
In-Reply-To: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
Subject: Re: (subset) [PATCH v8 0/3] dt-bindings: mfd: twl: Consolidate and
 fix TI TWL family bindings
Message-Id: <176229761865.2840692.9613824843684430886.b4-ty@baylibre.com>
Date: Tue, 04 Nov 2025 15:06:58 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183


On Sun, 14 Sep 2025 21:25:13 +0200, Jihed Chaibi wrote:
> Following extensive maintainer feedback, this patch implements the
> "define then disable" pattern. All possible child nodes are now defined
> at the top level. Conditional if/then blocks are used to explicitly
> disallow sub-modules that are not present on specific chip variants.
> 
> This refactoring also moves pre-existing sub-node definitions
> (e.g. madc, pwrbutton, gpadc, etc.) out of the conditional blocks
> to the top level, following the new pattern.
> 
> [...]

Applied, thanks!

[2/3] ARM: dts: omap3: beagle-xm: Correct obsolete TWL4030 power compatible
      commit: f7f3bc18300a230e0f1bfb17fc8889435c1e47f5
[3/3] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
      commit: 3862123e9b56663c7a3e4a308e6e65bffe44f646

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


