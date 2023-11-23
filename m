Return-Path: <linux-pwm+bounces-178-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309687F6926
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 23:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628FF1C20905
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94512E82C;
	Thu, 23 Nov 2023 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1gYtJQt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ADE18054;
	Thu, 23 Nov 2023 22:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D596C433C7;
	Thu, 23 Nov 2023 22:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700780218;
	bh=xrj+obBZs3qijThw6u7kIITase46Q1QURXGiZSMGFBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y1gYtJQtAsh/3wDkm1vHs4w6EFT+mCVIJim+KIK4QMFoBPToLX+XkRyHlJdL0ifEt
	 /wMOEiin3ay+eZhGsN/Mje8lKfSCTvzvlmwaWOOQ85kxvS4+BZ1hQsgyNM7uxvHHnV
	 cJdMWAVyZrQszH7Y/xNibCt2eHHodroA6dTLIAHT2AX4Fd0M/xFKy1kIsCy6b+KwUG
	 s6hN4kFDEZWpi1mrThOEzSbMh39+Xk0us1+VIsqVubslupACV+nQG8Yg81nSxLzjZT
	 jDr/3g+D/ZuhH5UsoPym38EDYqtVbxgzLqEiFFePC7JJOYi0RFVtYsivtGzaQQPILm
	 vQ2SwaTuz5W1w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Nov 2023 23:56:52 +0100
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jitao Shi <jitao.shi@mediatek.com>, Thierry Reding
 <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Xinlei Lee <xinlei.lee@mediatek.com>
Subject: Re: [PATCH] dt-bindings: pwm: remove Xinlei's mail
In-Reply-To: <20231123172823.4offrr7w4tsrhl4y@pengutronix.de>
References: <20231123134716.2033769-1-mwalle@kernel.org>
 <20231123172823.4offrr7w4tsrhl4y@pengutronix.de>
Message-ID: <bdfe874642d0b24c7e0ceeb1109361ff@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

>>  maintainers:
>>    - Jitao Shi <jitao.shi@mediatek.com>
>> -  - Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Xinlei is also listed as maintainer in
> Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml.

https://lore.kernel.org/all/20231123134927.2034024-1-mwalle@kernel.org/

In hindsight, I should probably have put both patches in one series..

-michael

