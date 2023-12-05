Return-Path: <linux-pwm+bounces-299-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14CA80544E
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 13:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD491F213D0
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Dec 2023 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1938459E33;
	Tue,  5 Dec 2023 12:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBTPviJa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915B5C8F7;
	Tue,  5 Dec 2023 12:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAD2C433C8;
	Tue,  5 Dec 2023 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701779783;
	bh=+INCrdUZpQez1lTz7gtEnYDtsWImW9U90WiUSUnGGIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBTPviJabSwQcg4gz+rK4kKsa6wtSX31gkZXS5Gk6EpRsUrPmnKWUhTaWIR4Vgsjg
	 mueM4+IsEb4yIuCaR/CYuwkhaVfPmKByrXxIQKJucgdrXm58K2sz6sWf1GYG3WWdH7
	 Gw66xYH4m0+mn+Syra9Q6frSOtrgMILyoCeNFA88v4+/XUE3k1BjEpsmyMBATPyc6P
	 qRAGpNb7gnjDtDgpykc9d5Dm6nWlIiL352ziXPuBtimCGL8e7j9yk3edxHAI2zszIg
	 818vjuiLSKMb0m/L+SkO0VZ2JXbgT4rmRGMwj0+oaXTiwiViqSHkQN7zEWWkolvIb4
	 F/a7dYkn+GIYw==
Date: Tue, 5 Dec 2023 20:36:17 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: pwm: imx-pwm: Add constraints for
 #pwm-cells
Message-ID: <20231205123617.GI236001@dragon>
References: <20231106095205.231210-1-alexander.stein@ew.tq-group.com>
 <20231106095205.231210-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106095205.231210-2-alexander.stein@ew.tq-group.com>

On Mon, Nov 06, 2023 at 10:52:03AM +0100, Alexander Stein wrote:
> Only fsl,imx1-pwm comptabile devices use #pwm-cells = <2>. Newer SoCs
> supportinverted PWM output, thus #pwm-cells needs to be set to 3.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

As suggested by Uwe, I picked this up too.

Shawn

