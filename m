Return-Path: <linux-pwm+bounces-7023-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365D6B22B4C
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 17:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2204E3AF4C9
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 14:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A092EFDBC;
	Tue, 12 Aug 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPgTTLoL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA019311C18;
	Tue, 12 Aug 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010456; cv=none; b=D6XcQdfIHfTnh9UTx6spBochQ1tIY+2DuDNU02es1CenRvCgiqe1nNSw1Kr4DCD6+8kScTWZfetIGek2yJ6wu8tTSfpUZHXmVT51Y/E1hwJEtIYCp9XPldC88PGEowHGgJgYQTawRG5WkbhT+qKKLWscrzmy4hmQPnNz/VNA9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010456; c=relaxed/simple;
	bh=6pI6kv0289+5HGzGYD4ZwmD4e83daVjaIOswUg35e+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3wJ9NhCG1RvlVRx3P92kpYsf+rMYCYtGccBGSd3sgOAiNIhHdJ1pQzm9sHCjAMINbWf7HdIkq5d9y0sskW+wH5EITKdzrB/I6uYCHJePbRJKNVRJUJzyWxlj/JAcnmcsz4t152g4pcoUKGgmqepP+r+ymXAofZ8uhYoJHvAsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPgTTLoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B78BC4CEF0;
	Tue, 12 Aug 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010456;
	bh=6pI6kv0289+5HGzGYD4ZwmD4e83daVjaIOswUg35e+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JPgTTLoLqe8lR0yg5vbUjDT+qPRN4AaGU6hRt+7dRDbVNHeBUsH95943N4NQ6dbzX
	 XrnA90tp1fpbZg+BLUjHyvOus/wnfhIUyt4Oq/31+spstDgSJPri72hDYxMMj34Swc
	 berbxtsDQo1uKWCzPTykSlApoEUZ26kPCE+2pil22xWNXqSj2LIq4DeD3iPyq+NNR+
	 cFoGeW1Q0P3J4b5mcJR9At1q54LUKYoJ6p0vIBKHiC7RNTw/mfZJwabcArjlqP+Dv9
	 QYb0+klhialiVpQJA8EhBejCyObLMWyR31T947fsz/DI2VpkwfrZx+qUW7kVewAmvA
	 Z5ySg0U/Poy/A==
Date: Tue, 12 Aug 2025 09:54:15 -0500
From: Rob Herring <robh@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: tiwai@suse.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org, ukleinek@kernel.org, krzk+dt@kernel.org,
	dmitry.torokhov@gmail.com, broonie@kernel.org,
	linux-pwm@vger.kernel.org, lee@kernel.org,
	linux-sound@vger.kernel.org, lgirdwood@gmail.com,
	peter.ujfalusi@gmail.com, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, shuah@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/8] mfd: dt-bindings: ti,twl6040: convert to DT schema
Message-ID: <20250812145415.GA3607226-robh@kernel.org>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-3-jihed.chaibi.dev@gmail.com>
 <175496188325.1486426.9118766970247515386.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175496188325.1486426.9118766970247515386.robh@kernel.org>

On Mon, Aug 11, 2025 at 08:24:43PM -0500, Rob Herring (Arm) wrote:
> 
> On Tue, 12 Aug 2025 00:47:33 +0200, Jihed Chaibi wrote:
> > Convert the legacy TXT binding for the TWL6040 MFD
> > to the modern YAML DT schema format. This adds formal validation
> > and improves documentation.
> > 
> > Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> > ---
> >  .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
> >  2 files changed, 155 insertions(+), 67 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/ti,twl6040.example.dtb: 
> twl@4b (ti,twl6040): 'twl6040,audpwron-gpio' does not match any of 
> the regexes: '^#.*', 
> '^(at25|bm|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio-key|gpio|gpmc|hdmi|i2c-gpio),.*', 
> '^(keypad|m25p|max8952|max8997|max8998|mpmc),.*', 
> '^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*', 
> '^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*', 
> '^(simple-audio-card|st-plgpio|st-spics|ts),.*',

You will need to add 'twl6040' to this list of exceptions in 
vendor-prefixes.yaml.

Rob

