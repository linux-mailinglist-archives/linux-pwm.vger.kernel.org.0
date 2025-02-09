Return-Path: <linux-pwm+bounces-4833-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25341A2DA41
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Feb 2025 02:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129CA3A2C7B
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Feb 2025 01:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E2324338F;
	Sun,  9 Feb 2025 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0NW5+wA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FEF3208;
	Sun,  9 Feb 2025 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739064934; cv=none; b=Rb1aa62TEE3ukSrAZ6AA4cilzYdSpYBpRE0X6XhrJ06gZy5lMG8QdAu3yFGyPbbWXRk8Ixj+OBXWjYTa541vFYNEuWdBspBEonnoYY4nkWjb/ymX8v5IUV9rZL72QrpEm0UhrYzRpg44b2+4X7F5oP3y1BYoFvbGDnDzLuzEBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739064934; c=relaxed/simple;
	bh=EXdIuJu2pw7l54KzBjnaxTJlUBEIjwt3/pux7qLrScA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjNeXV9t9SJ6gUmhsFTl/8gC35kyJG0IXD3macuUj44gsVCiqSDpc8KtO2sDwz2Wxk7u6j/iSqvwAHNLhVLM5n8PWwccPkBmHTTAS+gtYwyz3v/VPM20Draf20ksnkXk5rdhHbYc4px1RTxNh+pLlq9ujOLbzSepb+LKlsg2EJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0NW5+wA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e45258610bso6851346d6.1;
        Sat, 08 Feb 2025 17:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739064932; x=1739669732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRKxhZCOCzmEWMOmRJ3g2FeSCwaByEabS7PO0p23q1M=;
        b=i0NW5+wAUNSMSS3v6lazhqjbDOVZRwi2tuUXDabDoJo48AhWpAP9M4xqckYryuqo26
         pMETVsEyxPhS9g2g+pyqo1nnv6XX+0y9qIWcOupHzTwGo3z62N5X0tMtmB1oakQfnhdU
         OBHb6xROO4OXwFF4GVl8upA2qjFtCDaLP6PYTLtNCxrgEAMwyp1poNOrYpeWcnI25Eso
         DdErPcmbX25jhv0jgvR7SY7L8yfqpdaJlcSCTzkOuvEyWYKWCSq/isHLOGaYBuPP5V0l
         38Tjldtrk0vkBkQvwsCdlUD5E8ZZEa+1f4jEmO3zuE1u6RK6Wo3aJh3EDHrmDn3w7cVH
         gkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739064932; x=1739669732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRKxhZCOCzmEWMOmRJ3g2FeSCwaByEabS7PO0p23q1M=;
        b=LxMEiZallTZb0O7Xn4nyUFILUl8nA70ORgIj107P/2M0ZgYiGm3KYjH2HxjBCPYDWm
         OSxnNXnek7L/UphEKYBOEfGd/5tA9x4GrcZ8qZm5TJXA6HGGSW/eMP0DKskYQxj4dMCy
         FGvkjh/8h5VkT7K375BymeBosiRPQm64jCYqDyLZenve7nkeQngaWxs1V9LHyOo9qqg4
         WtBKjl2BawJP89ezsu2UFcNF3+AN5hN/pxbp143Fzr+WjQOTmXq0MuK25G0cer/TuRrr
         861ZcX3BW0WF1zxuTDffuPHsPPzzAupzT0z2FZwT1rlPYLGuIAPZkFlAa+Ym1EEJadN7
         kExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjFj2eri92WmXWs1SsK6HkJuAQaMCiTcScp4j5weTttc4uuUl7QOMCeDC0b9dfNPBSbY4050hx5sAb@vger.kernel.org, AJvYcCVwrnZIiWs64wQcR07lI5wc3lrPEGifbhw2QJWCrmbddWen9t6sI9W5e+ze/U2jXhJU/TLciHcj56v/@vger.kernel.org, AJvYcCXcbtT1svQCDsPjQFgwuZKrq1YQHwUP4JgmCAiHUoskHJ8dTPm3RkVAjNHYJACJjckdPGGA/68LyXTU1sHz@vger.kernel.org
X-Gm-Message-State: AOJu0YxukRB7nW6Wxq74aRzizprjgpRXb1qhC9r9piT5+Ap/lgc4NkZw
	vOc+spzCt25+oomrczOoVoJ3biqh0ktnCDTuaSDHsaOYPQnjs6aiPb8otw==
X-Gm-Gg: ASbGncs/byWVJh2LkY9rnJ4yHVgnOQKs/G1QSkmRypNNp7N0Bww4tX8i+iiT9d1MmbD
	iFoxfZbtEPwc1dNYOzi3i8o5fqXYAHH8Yj3/QszXatGTzGwPjswaCqHkhYtf0vZcfHmIw1Vuhqe
	1ecqQkgyqsxruhSzwNVBn2thjg4him5/iVAlz5GQhz/7C72yG4K2Xh7V7xevLmCCUztstCL9Gd6
	jD08WvCH3b+ZxdXU061snwtTycBk8Jzu0JVM5huzU+BKL856VhHmrgELpCvFB05C0c=
X-Google-Smtp-Source: AGHT+IG/BVHvdXAXof5qqJIuc21MLNDf2r+VR4zGQM6LRrXsfYAW+xMKs7Mf2rV7lWGzVoimw2X9dw==
X-Received: by 2002:ad4:5d67:0:b0:6e4:25ff:4bac with SMTP id 6a1803df08f44-6e4459a5cd6mr126757016d6.10.1739064931991;
        Sat, 08 Feb 2025 17:35:31 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e44f7dcdf0sm14316486d6.39.2025.02.08.17.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 17:35:31 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	Chen Wang <unicornxw@gmail.com>
Cc: Inochi Amaoto <inochiama@gmail.com>
Subject: Re: (subset) [PATCH v7 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Sun,  9 Feb 2025 09:35:25 +0800
Message-ID: <173906491553.817664.3244041315572858075.b4-ty@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738737617.git.unicorn_wang@outlook.com>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 5 Feb 2025 14:59:16 +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add driver for pwm controller of Sophgo SG2042 SoC.
> 
> Thanks,
> Chen
> 
> [...]

Applied to for-next, thanks!

[3/3] riscv: sophgo: dts: add pwm controller for SG2042 SoC
      https://github.com/sophgo/linux/commit/255f83ba5c16b0f79ad0c46c69b2e907012bde83

Thanks,
Inochi


