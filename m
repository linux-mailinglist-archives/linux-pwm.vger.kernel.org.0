Return-Path: <linux-pwm+bounces-3060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DB962557
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 12:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B851C214BC
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Aug 2024 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8954716C680;
	Wed, 28 Aug 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OBslnhaY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E874516B3BA;
	Wed, 28 Aug 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724842719; cv=none; b=la1G2hN1ZykLjGo8opgpKFBsiAtESClpubWDz98SCG9HcrVhfWLrRYyZxrBYDcn/NG7kV8GIxwxq6VByVX+3taOz9wVwUP3WVZilzXpOAjIuwAVohV0qngHEbcIoL8fRnDl7cxI5P2eos7mvFXjZWM71WY6lLZ8p42Rbhd7Hwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724842719; c=relaxed/simple;
	bh=faWKWd/jRfhvXNUmojC7SgOHNgJ64P7fWSIx46KxdIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NofHTiFounqUYfdMMVwEJ0PMSdqJEyllKcfZ8BZlhZf/PU9xULL4L/zz/O1WbL2jiHzzygqD9wIILtiK6J9NoxAov6PG9bMBvgyL/NF1ed03DGbqHkPclM2F2IEVMJb2NmM/GEpbeoc/PxLAN34rWVQLBlV/OZ/PaDCWIpA21dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OBslnhaY; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63163220;
	Wed, 28 Aug 2024 12:57:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1724842647;
	bh=faWKWd/jRfhvXNUmojC7SgOHNgJ64P7fWSIx46KxdIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBslnhaY4XKqvj9xzuTx17N3jrJa8erfptO1Q76buFjYV71UNunWyqm0I7Ft2GJbp
	 3N3WijcfcaVLnThbpncT8hQFXywZTe6/ranac9Q1lMLsDnA+G8xF5ZVTs8m1uXNOx5
	 gfPxCecd5M0O+U/E08yyJPDed0cV9MlKobT2he4U=
Date: Wed, 28 Aug 2024 13:58:30 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: haibo.chen@nxp.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2] dt-bindings: mfd: adp5585: Add parsing of hogs
Message-ID: <20240828105830.GK30398@pendragon.ideasonboard.com>
References: <20240828030405.2851611-1-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828030405.2851611-1-haibo.chen@nxp.com>

Hi Haibo,

Thank you for the patch.

On Wed, Aug 28, 2024 at 11:04:05AM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Allow parsing GPIO controller children nodes with GPIO hogs.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

This looks good, sorry for forgetting to add it in the first place.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> index f9c069f8534b..ee2272f754a3 100644
> --- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> +++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
> @@ -42,6 +42,13 @@ properties:
>    "#pwm-cells":
>      const: 3
>  
> +patternProperties:
> +  "-hog(-[0-9]+)?$":
> +    type: object
> +
> +    required:
> +      - gpio-hog
> +
>  required:
>    - compatible
>    - reg

-- 
Regards,

Laurent Pinchart

