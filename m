Return-Path: <linux-pwm+bounces-5143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F82A5EC86
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 08:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F801652C8
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CFF1FBE9C;
	Thu, 13 Mar 2025 07:10:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D283381A3;
	Thu, 13 Mar 2025 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849846; cv=none; b=ViyJGqwi+GSKA9f1jZeY5rhx/KUHulDf8U8TPfxNqG7D6FxUvDLbzavWuzGIH/MFtb0fls7/e749zAPUharR012KT8gB/w//NFyFpqWpvQStOk7D9hul07ZoFKixRuzsP8C7mRh9PpYIXzezQUisyipjPYFaJb6caeFLuT6vkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849846; c=relaxed/simple;
	bh=i85AmHmB6Aj/vkeWUd+2nOH9uaob63d0YwFApO+uWhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUiySCu0q2/rMo/TQN04HZfWAgBxn1aLqJtJv84a3hww+zPfC9rZKNCQI0Lll7BaALghxm8unL1bDRVEzewaDHWyeGr9LLlhktWjJcc/jU+37NcR5Fc9zCu6OXBWgBOObKSUQgOxQlulz9lkxR/DZcAegG9XPLkdzEeoMzvRtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id e22876d9;
	Thu, 13 Mar 2025 15:10:36 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: heiko@sntech.de
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add pwm nodes for RK3528
Date: Thu, 13 Mar 2025 15:10:31 +0800
Message-Id: <20250313071031.1840032-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <7779050.EvYhyI6sBW@phil>
References: <7779050.EvYhyI6sBW@phil>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHk4dVk1ISUhOTx9PSx0fH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a958e573b6203a2kunme22876d9
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6Cio*IjJDOhABOiIPMxw3
	QhFPCgFVSlVKTE9KQ09CQ0hMSUNJVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQU9KTzcG

Hi,

> so yes of course the pinctrl needs to be default - simply because
> that's the only pinctrl state mainline supports.

> But judging by the fact that you're discussing working vs. non-working
> below, can you please check if we should drop the patch for 6.15 till
> that is solved?

I suggest dropping this patch first, I will send v2
when this issue is solved.

Thanks,
Chukun

--
2.25.1


