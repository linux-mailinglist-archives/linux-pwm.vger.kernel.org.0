Return-Path: <linux-pwm+bounces-5461-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C23D3A862D8
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 18:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C830C466F09
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5AF2144CF;
	Fri, 11 Apr 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXhVy8mq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D8376F1;
	Fri, 11 Apr 2025 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744387533; cv=none; b=BwmN8zC13nE58rW4/YKKN5yNiOJyfxEhtlsl3aI8YUJN3a6a9Cz0NUkfAlUnRlf0ENceYR+H639pXOl9g9ZNId6SMamUrQyCO+zIACFBI17kUVtZ6ETgQLcZL3fnlZHsZEHW2xCkmPKta0qq48kh+HasSOO2Ct/1bDv1Q+nacZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744387533; c=relaxed/simple;
	bh=Ql4MKbHYn0LYUmCqBEk+Nsc4K3zGFojAGH/c0V7kks8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reyGcKjexLqM++FNF6HVASXiWBb7//4a0ly01fGi6+azDAU4FRvzx6Luj7fkDVrJw+I1n+wuIi74HFN757pvDmpzDXssHgX6M1y0P7ERs3uivfhz9gGaO0ihZ/A2RXPFWiBPiTIVdKSEQC/kZEc3Tb50yIVbl04KIEoZ+Jo8gTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXhVy8mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5AFC4CEE2;
	Fri, 11 Apr 2025 16:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744387532;
	bh=Ql4MKbHYn0LYUmCqBEk+Nsc4K3zGFojAGH/c0V7kks8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXhVy8mqPgH6iNMP4+lN8KNPVXoFje6XG5rQFRyuLKVcYXED8/uujYcMza1jW81ST
	 t2FpJ0iq8DIs7wAIvSxUDGbD7ttiEtdyzun9uvrWkiNsI9AWQ4jwRqYR8nsW+kIDIW
	 nt+WxmSkLSoZf3VmG0zjf4EClldhybwBxLF2drK3FKSBAIgpCf9WBjfeBd3dnCSwI2
	 WKgGRFwrbXArZFQO7r6aea1VNmzD/dLb86VzcqTt5i4J/BapByaUpYtCLUAJKRZo5d
	 M70gZwtqbyIaSVoKl5FkS0IjqO4oX8DlzW0eJxZCXovJyZtXaxOp2kgmnEbaNVi48p
	 ORB5HE8Gwq34Q==
Date: Fri, 11 Apr 2025 11:05:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	andriy.shevchenko@intel.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>,
	linux-pwm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <174438751337.3319673.5204335405880872375.robh@kernel.org>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>


On Wed, 09 Apr 2025 16:55:48 +0200, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
>  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 171 +++++++++++++++++++++
>  2 files changed, 254 insertions(+)
> 

With the typos fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


