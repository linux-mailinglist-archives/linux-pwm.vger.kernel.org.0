Return-Path: <linux-pwm+bounces-3061-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F1965A33
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2024 10:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D38C28B2BD
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Aug 2024 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418DE167DA4;
	Fri, 30 Aug 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjnDETLW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B114D294;
	Fri, 30 Aug 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006263; cv=none; b=nWd53U+60B7f7jWzJ/4klD/x0eMsyTIC9Gb4SaT1ytITKLtyY9mjRJrumXmglPrLBQACHYY7EIvO7wVHo9ue2ZVlj6NryMAJc2yk0KxKYYNeJCtSbfr/1uTnwL8RhmZWYewuTum8m/7q06OLs4sBCFwNX87WUNeoCyOmTd3q1G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006263; c=relaxed/simple;
	bh=2tR2hRQ1rYChuVlupkc+56arNudu9Oi8Rf0EuNIq87E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pwk1JvZEGnoPU28ZS5F+v5jTaADlrJXvbQtSc4Wm3KNVE+JZQeJFMLmbCPxM7nwq68n03zkuCyxawbdl0RXPIjyIEI0gCoMoF0IkGDQpTflTDpPE9I1sqEiYJJ9sxOLp41CyNNUtie+s76ZoC3nbycLobeztznIwMyl5TTg2zp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjnDETLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9697EC4CEC2;
	Fri, 30 Aug 2024 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725006262;
	bh=2tR2hRQ1rYChuVlupkc+56arNudu9Oi8Rf0EuNIq87E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QjnDETLWpLZXqCOaY0PTfKYzUTjf0S/WCjJ+24pvcV2pOXSaOMQqYXTjRiVpXRjUd
	 dflF9AcXoJrXxBVRs2ojyVuvHr7efs27Hd2AGWkncR6zW8+GbjtK+mV1upJf6O0KEd
	 IaDl4O32tmXGz5zMIdRI6dncE3w1N0l5aTbnrS1uM8OAXVx6VG3qT0G21fbW1ra1bw
	 kSw5DCFqIC62VyG2QBxsCEaV0lXCxFpGht/bqSZtBBgoEaZ+HvkdUt3UrIKMDeHe+3
	 lMDMLdAF8boF6t4F/daeaN0jJSckP72nzJbZjUCq1DkyWKxxZjUqD6ecKtS0evGstV
	 DKFY50zVLaKhA==
From: Lee Jones <lee@kernel.org>
To: laurent.pinchart@ideasonboard.com, lee@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, haibo.chen@nxp.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev
In-Reply-To: <20240828030405.2851611-1-haibo.chen@nxp.com>
References: <20240828030405.2851611-1-haibo.chen@nxp.com>
Subject: Re: (subset) [PATCH v2] dt-bindings: mfd: adp5585: Add parsing of
 hogs
Message-Id: <172500626034.92906.922008422255613833.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 09:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 28 Aug 2024 11:04:05 +0800, haibo.chen@nxp.com wrote:
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> 

Applied, thanks!

[1/1] dt-bindings: mfd: adp5585: Add parsing of hogs
      commit: c9530dd31470c071b364801c90466a5c15942c25

--
Lee Jones [李琼斯]


