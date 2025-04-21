Return-Path: <linux-pwm+bounces-5633-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC2DA9581C
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 23:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D007A5BE9
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C437620F065;
	Mon, 21 Apr 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CunwQe10"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3E149DE8;
	Mon, 21 Apr 2025 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745271575; cv=none; b=tcRcqwN5virCCYHR+fEMc61JWNApBkG5WHTsSl7Q3cG8f32F2A/7+1Z6qB8InaUL7URemYfB/PA7SviDXUrGYYlK+UYEk5dFZhylVAK093oWRNiKsf1t27sSIkReIfYmynnG+aqQyaHBLmweeeh2sNlJ1fWBAduNfoDUTbxsLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745271575; c=relaxed/simple;
	bh=6oOfiEbDXZjld4J1a2eZRwXMdYXVf8MHpZBJgMbf+tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiMlqz/q+5+8J6w6fe+CPkAzHzjtMhm2g11RcF0YAiXndsvMtWxbKgXIvG6960EsMZvus61kQgim1oelMgS1lB2UoTSHacJX0Km1dLMluQLmKcjLuZztxM9xp21BeBdNAjdP0lHE4pW6Z/UtWLvE/FeCncHQNT5RTwV7EC8IIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CunwQe10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E01C4CEE4;
	Mon, 21 Apr 2025 21:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745271575;
	bh=6oOfiEbDXZjld4J1a2eZRwXMdYXVf8MHpZBJgMbf+tY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CunwQe10diTQj7Kcsc6C1CwB8Xy8oJvuzynsA78ZhRpwLBXJ9aIAUSd98DazZIPth
	 eDlAoM1267TU0nkzPjSf3vqTvrDBwHxWxw/BY67nP0OCKTsLizQfmSLioFenT7O6E5
	 a43WAEOFqaZ6MmV0xO58uXeel2v4J2hSyIcqAEJBtrGAKjdQShZRFhTZ7x6lQon/rD
	 tCgZ15ggXKX3P7IsofHhj1hwRCvg8OKbket/d9jq/Cfpcb88/neFGNf3LZWG4EDQJV
	 /xFAsNBPucisnejtJnhpJAvE4rrdW1VetBy71+jircRcsz+Y52HH9AgXsumJ8I3425
	 +IT5znrvENNww==
Date: Mon, 21 Apr 2025 16:39:33 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
	ukleinek@kernel.org, linux-pwm@vger.kernel.org,
	jitao.shi@mediatek.com, linux-kernel@vger.kernel.org,
	kernel@collabora.com, devicetree@vger.kernel.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: mediatek,pwm-disp: Add compatible for
 MT6893
Message-ID: <174527157255.2974366.16207591192162778004.robh@kernel.org>
References: <20250416120253.147977-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416120253.147977-1-angelogioacchino.delregno@collabora.com>


On Wed, 16 Apr 2025 14:02:53 +0200, AngeloGioacchino Del Regno wrote:
> Add a compatible string for the Display Controller PWM IP found in
> the MediaTek Dimensity 1200 (MT6893) SoC, which is compatible with
> the one found in MT8183.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


