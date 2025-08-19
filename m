Return-Path: <linux-pwm+bounces-7097-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06987B2BB7E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 10:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A916BFF9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Aug 2025 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CCA3112DA;
	Tue, 19 Aug 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIIFEWC3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8904721D3EE;
	Tue, 19 Aug 2025 08:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591271; cv=none; b=pBmZNfzmULaZF1Q7UiGK8ee6Ol0f5bpLqfMtLYb9mhi1RJPDh8LJjdmgvDRTSXJz3kBHojCYHXwE/5dVGU5im+zjSnkFhmiUILBAXcZOgmQyPB6bt9cqTO8lNpoLCOmDc8YBy5emGooriEB2oM2o4r3ky65EtHUSm6gY4d+cZ8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591271; c=relaxed/simple;
	bh=tqkaoqXSQS6r9ypIv8V3rL0fxCKcJQKIsmosOm7DlMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE80XgzRsE5zeykFbVLHBOiHDtVw7ylwTIIaOzOwJCn9sQbgqRc1zBTYAJ+yMybsXSoGASZRuG/XbnHXpv05srlv6JNzn9jR87L9bBINJzJdWYDA9lXdWQiFiRvFnI/ffneri/DmdDQX6OOyEkCY8n1Zd6elwcodBz7hMyRaP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIIFEWC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE84C4CEF1;
	Tue, 19 Aug 2025 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755591271;
	bh=tqkaoqXSQS6r9ypIv8V3rL0fxCKcJQKIsmosOm7DlMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIIFEWC33UWR/fYKDep/YSOwfh14lGoNfqxqfR3SQO0wyFdk4lZV753tQFSCBsfJx
	 EmJSjBaZbDwtgLF9PbPqrWiwxbXg0XZ5tmomzxJABsOfk+7sk7qPCgbyKGvpq/AGaH
	 aSYG1wl/9e12ENEI0PxIUgwOixY2aeWFUU69VTqF+mitoi6IsCgm+30zY3IJsJqnef
	 K/8rdUO141ef7PrryN7ZTqq3BAGSFlAA57lcJB4shf0azDPR6ecjx6lAKhs1GiKpBC
	 M3vSfIFD0Rid6+hcnJwGXxX5BNzQeUrAMXRZOkK0ulomKt3kFfOLoUoHJO0s8yhq1L
	 OgUOtLMZj8XfA==
Date: Tue, 19 Aug 2025 10:14:28 +0200
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
Subject: Re: [PATCH v3 0/6] dt-bindings: Convert TWL4030/6040 family binding
 to DT schema
Message-ID: <20250819-miniature-pug-of-whirlwind-acdfb6@kuoka>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>

On Sat, Aug 16, 2025 at 04:15:17AM +0200, Jihed Chaibi wrote:
> Hello,
> 
> This series converts the remaining legacy TXT bindings for the Texas
> Instruments TWL4030/6030 family to the DT schema format.
> 
> This v3 series addresses extensive feedback from v2. The main changes
> include consolidating the simple power and PWM bindings directly into the
> main ti,twl.yaml binding for a cleaner structure. It also adds a fix for
> an incorrect schema $id in the ti,twl4030-gpio binding and corrects
> various properties based on reviewer feedback.
> 
> This results in a cleaner, more accurate, and more consolidated set of
> bindings for this TWL family.
> 
> As requested, the unrelated ti,twl6040 binding conversion has been dropped
> from this series and will be sent separately.
> 
> Thank you,
> Jihed
> 
> There is a typo in the subject, "TWL4030/6040" should be "TWL4030/6030".

Huh? Why are you sending patches with known (at the time of sending)
issues? Fix the issue instead.

Best regards,
Krzysztof


