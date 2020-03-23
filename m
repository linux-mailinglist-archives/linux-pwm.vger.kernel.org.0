Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24F1C18F3C1
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 12:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgCWLgN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 07:36:13 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4416 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgCWLgN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 07:36:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e789eff0000>; Mon, 23 Mar 2020 04:35:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 23 Mar 2020 04:36:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 23 Mar 2020 04:36:12 -0700
Received: from [10.26.73.76] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Mar
 2020 11:36:09 +0000
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
To:     Sandipan Patra <spatra@nvidia.com>, <treding@nvidia.com>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
CC:     <bbasu@nvidia.com>, <ldewangan@nvidia.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1e40daf7-e5f8-7b79-cabe-8aceef6dda58@nvidia.com>
Date:   Mon, 23 Mar 2020 11:36:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1584963327; bh=Ax5Luu1Wgx/GtkJPbCn5+KhconBwWEM43/aV+eFmyS0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jUJqLG6NJAY/qZCEoFKvpMnAMPHll61DC5NFj9AqYPyzgsFTD0xv2wus1i/vAmlm+
         ibI2WfTWY/vZfBNtYniGGZ6vYn8OIyquhxhdV1bccnlZun2XqiZqk0HoA26SweeU+B
         mIW+sFhuPn8In/WlNxU5j/Dpy2KozDnwd9Z1vD/IhGIUh8snwlMdCYGGbV2A6rPGBp
         N4Ohqed20b243fzW8a4ohKYsg3Jqx6Q1YtENlXDq3q0aAXGyvopthBHr7sTQWnX+Z1
         LZA40P6nTXLa38vFLR1ZPsRenjrWSpZ+Yp+g8XcLhMz8bd7lwi+TJPBAGwKlILUa3w
         D+TOnrzR1R6OQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On 05/03/2020 11:27, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 1 +
>  drivers/pwm/pwm-tegra.c                                      | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> index 0a69ead..74c41e3 100644
> --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> @@ -9,6 +9,7 @@ Required properties:
>    - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
>    - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
>    - "nvidia,tegra186-pwm": for Tegra186
> +  - "nvidia,tegra194-pwm": for Tegra194
>  - reg: physical base address and length of the controller's registers
>  - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
>    the cells format.
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index aa12fb3..d26ed8f 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -282,9 +282,15 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
>  	.max_frequency = 102000000UL,
>  };
>  
> +static const struct tegra_pwm_soc tegra194_pwm_soc = {
> +	.num_channels = 1,
> +	.max_frequency = 408000000UL,
> +};
> +
>  static const struct of_device_id tegra_pwm_of_match[] = {
>  	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
>  	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
> +	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
