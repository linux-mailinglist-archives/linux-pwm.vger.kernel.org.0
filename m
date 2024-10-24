Return-Path: <linux-pwm+bounces-3824-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3929AE6EF
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CB2832EA
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614861D5AD7;
	Thu, 24 Oct 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvZhZ/Wm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6F136A;
	Thu, 24 Oct 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777551; cv=none; b=u75SzGhfBdM4N5v/DT4Y4T0429wzcgjaWT1mPNdT02O/LkMfrjl7yiKruVWDio6amuXY6t/ADFLaTEqZtwg2Hgl4lYWzyBSkpufnjloLwHJmeKAOon8Ffer5+vqNuNZx/0I06AwGHHQw1CsyHuBs0TKBwRq+2pBsSO/1DSXljEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777551; c=relaxed/simple;
	bh=wwPWvSBGUvSYbh2tv8Xhy1j32pV3xMYlKdte6yQ/l2Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=P3a65zOUTU75PgvPyAkrwmyoGjb0ijjYWC6CiDdcS11SU8gnT7GWbWFV4yki8EtKuS4UL7Dl8HiqAA+kftRd89NZmo/MeZ47ciq6uSSJpbQo697osdo2wp6TeGCGY2e/2lADtVgtfefcgKounF7cqhYI7efFvRq4loezSbBXCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvZhZ/Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AA6C4CEC7;
	Thu, 24 Oct 2024 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729777550;
	bh=wwPWvSBGUvSYbh2tv8Xhy1j32pV3xMYlKdte6yQ/l2Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=tvZhZ/WmfNUnyiKb5Ug+aYDARYpCaIaVruHf8RzheKEtrmA119942UEAyYXBDTIu4
	 Ij802krosYUO8QjsIiY7S0l0fkv7KWTLyVjKzJiRB/8+PTeYVyR2729dlbrS4xic9S
	 i3PNz0/nt5WYqKx5CZyeN+2RNC119c467bPSf2U7pLq/cBxS2XnRgjaLRKVD4e8Y83
	 +UUneGva/+KcjKgregL0zfY6OLdFOU1kuzilwUBX0YPJwC8zmbGVzpBYBfKWUQv4a8
	 t4htVWQwwVJ/KnXYfHbiTrWlisRfL6nwN8GK8ZwIgJSw3v0WKo6f8UMq9Y++my8OXd
	 vXDn+M6UHDTqA==
Date: Thu, 24 Oct 2024 08:45:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: BMC-SW@aspeedtech.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux@roeck-us.net, jdelvare@suse.com, krzk+dt@kernel.org, joel@jms.id.au, 
 linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, ukleinek@kernel.org, 
 linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
References: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
 <20241024071548.3370363-2-billy_tsai@aspeedtech.com>
Message-Id: <172977754729.100390.12938687199677719303.robh@kernel.org>
Subject: Re: [PATCH v1 1/2] hwmon: (aspeed-g6-pwm-tacho): Extend the
 #pwm-cells to 4


On Thu, 24 Oct 2024 15:15:47 +0800, Billy Tsai wrote:
> Add an option to support #pwm-cells up to 4. The additional cell is used
> to enable the WDT reset feature, which is specific to the ASPEED PWM
> controller.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Change-Id: Iefcc9622ac3dc684441d3e77aeb53c00f2ce4097
> ---
>  .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dts:54.48-70.11: ERROR (duplicate_label): /example-1/pwm-tach-controller@1e610000: Duplicate label 'pwm_tach' on /example-1/pwm-tach-controller@1e610000 and /example-0/pwm-tach-controller@1e610000
ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [scripts/Makefile.dtbs:129: Documentation/devicetree/bindings/hwmon/aspeed,g6-pwm-tach.example.dtb] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1442: dt_binding_check] Error 2
make: *** [Makefile:224: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241024071548.3370363-2-billy_tsai@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


