Return-Path: <linux-pwm+bounces-5460-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5917A86108
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4C04C357C
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219441F4C96;
	Fri, 11 Apr 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guWP4nwg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF11EFFB8;
	Fri, 11 Apr 2025 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744383041; cv=none; b=Y9k1MET/zn0J4BLXdFtbaZMNOvkP6gnqUSeS80ulB8XfnaoDzAu/wXHHTXtK/n8lLdla2CV5omCl6jfnj1CfO8yOhs/NXUv9s/bBpC3Vl8vZpOqN+2kpgwIF+tSIQ2gpt9Vka4JfWP1lsBxvvL9RUkPOAH1Q221dqDYHuohgvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744383041; c=relaxed/simple;
	bh=prfpkdJjH8gsyLeUcHkDF+9wOpbQqO3gBOF3+xUwy/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0SgLgIqc3QpthQExn+5qE32Y3o8jkfSa88X4jWcQaQZ9bUxam9faVu9aCmlydL95Qo62mJ4AtyZYXnZF7+MST0oXFcf1fp5ndHEHWZcxX3yIywKKNIva86hbjKZkW4W2FEN3SUdBIUsu5IiEDGmcmivQM18FB90is+mD/kAd8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guWP4nwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BA0C4CEE2;
	Fri, 11 Apr 2025 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744383040;
	bh=prfpkdJjH8gsyLeUcHkDF+9wOpbQqO3gBOF3+xUwy/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=guWP4nwgMlFbond9eIoFzKbNRUApAq4DpSSu/uFEe2lJxCjY7qC89aIsRtU4mwmCY
	 ywDRHzsC3PuVaBi27Mbln/fQ8V0JZ4vrm4fkr1qyJ8geT4mFyxFVGqlWP3Wy9xBsOj
	 iE6uDRTqAoIEt0gpODcbNY+uYZzAuODdINbDm1nwZ3H2kzZR2Wcvm5ZBqTwsyKONdU
	 cauDIW66v1944TXVhf/APuTPgmkIlCwDMBxNN0WE/xTR4MtwdXrBKPxpzXBaX1sDoe
	 b+987sx4ou7cOD8zge3vqg8FDzHPesMbZScq+Ql7snZtvGje/bdNuRJprXymLq40ut
	 jNqkMKZinmdfw==
Date: Fri, 11 Apr 2025 09:50:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-renesas-soc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: timer: renesas,tpu: remove DoC
Message-ID: <174438294005.3234652.6798896475162852160.robh@kernel.org>
References: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877c3vnq0k.wl-kuninori.morimoto.gx@renesas.com>


On Tue, 08 Apr 2025 06:09:15 +0000, Kuninori Morimoto wrote:
> commit 1c4b5ecb7ea1 ("remove the h8300 architecture") removes Renesas TPU
> timer driver. Let's remove its Doc.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/pwm/renesas,tpu-pwm.yaml         |  9 ---
>  .../bindings/timer/renesas,tpu.yaml           | 56 -------------------
>  2 files changed, 65 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml
> 

I fixed up the subject and commit msg, and applied it, thanks!

