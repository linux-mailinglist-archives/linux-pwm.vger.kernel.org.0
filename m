Return-Path: <linux-pwm+bounces-4023-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2D9BAB07
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 03:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3341C20B94
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2024 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1494F166F31;
	Mon,  4 Nov 2024 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="goFkIbwr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50EB3F9FB;
	Mon,  4 Nov 2024 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730688738; cv=none; b=k4YQgGwoS3IhydLaT5TdR8L5TLh4gOu6GCj+nx0bWKvRYjlXxhNNianasI7bcS/IdMz1gftjPUE18DFLFg75pZrSZ4bOuTe5Ux7RO+hs7FYFbxEFkaQCVvi0fM/ttUs2yFaRNK90MGbmxJH3eVPvDsWnreqGB15fTyBLQMuXJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730688738; c=relaxed/simple;
	bh=1Sl5QhNyCmtNyRjl4OsiYZvOXj6rY7zOuc9KCO9hutw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSman8RRtXlYXZM8jtblEph27yCngAqyRx57dt89GOFiHsgB6RbgjH4B7H9cj93DIC5OnpKgMVGB1qPrX5dKwaVcCXvxb0qm7zDmI0Zb/iDEHfYjN3tf4cAETOI4LFLyDdsNQI7dMFklF5wvBTphg6rz8i1OYxIhuIgIDjNGpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=goFkIbwr; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730688731; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=StKUPN4/P6eCIYq7yP9Ejz/p0E8GQsTmFTPTj+yjUBc=;
	b=goFkIbwr025jwwA85cxYG/p4ZRcymwZLMfCNA3nBumvLkHhB1HmoHdwlNWTAoFIGXkf+NIjV2RApluMxAN6xhODqyrgQYnUljXwvIQNtv/fgjRkwP64dJiFuNKUg8OfeCBBpy+HLPdAj6SNX67RkWezABXqG+PYECmRtyT0Sss8=
Received: from 30.74.144.113(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WIZuwsf_1730688730 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 10:52:10 +0800
Message-ID: <84dfe382-65d8-4743-84ba-d70699b6f5e7@linux.alibaba.com>
Date: Mon, 4 Nov 2024 10:52:09 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, Orson Zhai
 <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
 <ielio4ys77kgo5qsvrbbqfg6yzlit33yun4leei2giplbedsc4@5qmkwgvqe6xl>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ielio4ys77kgo5qsvrbbqfg6yzlit33yun4leei2giplbedsc4@5qmkwgvqe6xl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/11/4 04:24, Uwe Kleine-König wrote:
> Hello,
> 
> thanks for your patch, looks fine for me.
> 
> On Wed, Oct 30, 2024 at 10:36:36AM +0100, Stanislav Jakubek wrote:
>> +maintainers:
>> +  - Orson Zhai <orsonzhai@gmail.com>
>> +  - Baolin Wang <baolin.wang7@gmail.com>
>> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> 
> An Ack from (at least one of) them would be great. I see Baolin Wang in

Sorry for late reply. Look good to me though I'm not a DT schema expert. So
Acked-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> the recipients of this mail, but with a different address. Does the
> maintainer entry need updating?

No need, I have already done the mail mapping:)

