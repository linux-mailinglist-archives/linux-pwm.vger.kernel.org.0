Return-Path: <linux-pwm+bounces-5134-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F996A5D784
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 08:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65DB2189E7EE
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Mar 2025 07:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA422689C;
	Wed, 12 Mar 2025 07:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="2NMSr2Ed"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA341CBEB9;
	Wed, 12 Mar 2025 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765582; cv=none; b=ey5u1CjZRx/euHKywcC66HDfU+Tt4+7g8XWkvAq1hc80KnwaC1wfRyaLbhKh/9pmL+P38DOnoR+PQ8MKmP3v7CJZpSfSX+ig0wDGMQfuHf02JXnVEeEcPvOMtEmB/YwaPB+SQuSvyG8qipsuf/RUxB0A30tGkDLnqEqCVatv5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765582; c=relaxed/simple;
	bh=QsnFpCm/unlAsT7zJ1emM77YdMbgo/TGO6rGmdvJlSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh7vNLBQmqfd0Qjvhkis/GB1ilrOEVdUD0jriWo3vshiEijCriJeALS8ZoMLG8ysryoreZqu3rWagN1vr54CRInLHQfYePkK/Xd6bXwcDusDljc83j3ZvzlNlfzh83H34B820wa2d1nv5hrfB+1+WkayoSt24ygzMCriQc1gxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=2NMSr2Ed; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RIr0sQIfWa4T3BPRRuuVacSrn8+fQt4tblX1wU8anCU=; b=2NMSr2EdI/5uCqDILkGsak3e/k
	8QPm9/Xxz5AL6lJH00q5jHTHpy+XolBg/letmAxrIwLH27C3+G9x+izrEE+pxAYcEpP4DMlNab3fH
	RTxqi4Du/yok3DB5tkm2UAhV3Lx1G/HkvrfmiUTjVJlvma988l3P4JmS6sXH5onnt7ILCqL4EL2YY
	l3oGF+rQ0JvedmLY+K0fmryLy7Ks+RN6NqnGuz/4hbWd1ISEbNepUSjt18BbqMBj6YhaSEYYS8E+4
	BPxjGJXkMlLEwLB51JZNEPSjy/IyKErflpVEuAHcSdftawZ6yIc+piwLvbBO3meAgJH2u1R2EV0Tm
	e6bmPn5w==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGn5-0005zY-5W; Wed, 12 Mar 2025 08:46:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Yao Zi <ziyao@disroot.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Wed, 12 Mar 2025 08:45:56 +0100
Message-ID: <174176555637.249409.2785731072183565436.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250307120004.959980-1-amadeus@jmu.edu.cn>
References: <20250307120004.959980-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Mar 2025 20:00:02 +0800, Chukun Pan wrote:
> Add pwm nodes for RK3528. Most rk3528 boards use pwm-regulator to
> supply to CPU, add node to enable them. The PWM core on RK3528 is
> the same as RK3328, but the driver doesn't support interrupts yet.
> 
> Unlike other SoCs, pinctrl-names need to be in "active" state,
> I'm not sure about this, but otherwise the pwm-regulator will
> not work properly.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Add pwm nodes for RK3528
      commit: 2973d077aedfc114affab96c3b2c7286163cc8c9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

