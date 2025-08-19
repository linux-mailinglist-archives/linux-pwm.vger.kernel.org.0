Return-Path: <linux-pwm+bounces-7095-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470CB2BB6E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C3B3B2169
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113A310652;
	Tue, 19 Aug 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzX++Nil"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E32B9B9;
	Tue, 19 Aug 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591094; cv=none; b=ctMUowUP6yNnab2NfU6FB9Vv06F/Rq3nXLRGf1OzTXXHwV+DNBO1UzlaiYJyCEEueRpHAwvdLm/8rukeHFRI9WP/ca+b4x5kXC8gjWXwUX843ZzIBOstDgyg3SC2dfCwU3MkN4teAjW5AmMpYCj60rZCjv+So40ZxV9LP0iFPks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591094; c=relaxed/simple;
	bh=3j9Oxbq/9jtnjR827ybfCD0f53dGZ18zhqTHoaC/+ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnfiOxgBhv+CCFaLU577KdVSLifCrPIFmeTb41T2xlp//qIYvmldB5acxtUx6ixdglvNtvsLhmPjDfimXNjFXZvNVg8MLMkVCOJLqPam2crKREosjB0wA5llY0pyx4YTZU8B0CFoIRRFLOEtzL4LgAN8M8e7foUwe6WQGy4mJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzX++Nil; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D998EC4CEF1;
	Tue, 19 Aug 2025 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755591094;
	bh=3j9Oxbq/9jtnjR827ybfCD0f53dGZ18zhqTHoaC/+ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzX++NillaBCks+hjcA7hDvXB2rWf9gQVUqvbPGyWil7O7XN5ciiG4pBkCUGtZece
	 7G2IuPayDrM02yI6FgYuD3rxRBAqnUmmE+LDpsq2xOIJNzPvoc1ebE2NyQ9oGkIN7w
	 AtP075qiDakx7jzeC6ov/2tsNXx1YftM02oLhpr1ob2vwCsqHUyBdZ5n/FI0NpAqZZ
	 2O2p3uTScLX36laWk7MWRbfWuSZBWx3cc/SlKrEmCOMTlKQnKqZ10J6gv/dAyOmIjL
	 RMmbHaxpN3MGjkfZ5v5Yf/zqulHv5zykX/8NBBSX74+drivXa9WCmkvXYpu//Sl2v6
	 qQMYo0wUp/KVA==
Date: Tue, 19 Aug 2025 10:11:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, andreas@kemnade.info, 
	peter.ujfalusi@gmail.com, dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org, lee@kernel.org, 
	ukleinek@kernel.org, broonie@kernel.org, gregkh@linuxfoundation.org, 
	linus.walleij@linaro.org, brgl@bgdev.pl, aaro.koskinen@iki.fi, khilman@baylibre.com, 
	rogerq@kernel.org, tony@atomide.com, linux-gpio@vger.kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, 
	shuah@kernel.org
Subject: Re: [PATCH v3 6/6] dt-bindings: gpio: ti,twl4030: Correct the schema
 $id path
Message-ID: <20250819-daring-shaggy-fossa-ee6d6c@kuoka>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
 <20250816021523.167049-7-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250816021523.167049-7-jihed.chaibi.dev@gmail.com>

On Sat, Aug 16, 2025 at 04:15:23AM +0200, Jihed Chaibi wrote:
> The $id for a binding should match its file path. The ti,twl4030-gpio
> binding is located in the gpio/ subdirectory but was missing this from
> its $id.
> 
> Correct the path to follow the standard convention.
> 

Fixes: 842dcff8e2d6 ("dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema")


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


