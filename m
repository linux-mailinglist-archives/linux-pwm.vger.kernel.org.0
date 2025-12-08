Return-Path: <linux-pwm+bounces-7774-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 387D0CAC3D0
	for <lists+linux-pwm@lfdr.de>; Mon, 08 Dec 2025 07:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BEDB300316C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Dec 2025 06:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB582329C54;
	Mon,  8 Dec 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccskhqZ2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBAB329C42;
	Mon,  8 Dec 2025 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765176522; cv=none; b=IhigM+7JRyTw56cgfkb5LPHluqhq+GqR2xKTfNnZFbe8zC+/eXpyneDla2PoVzWUpnlHaKP8sn+2riB9w0XxqlnPT8ggPZUiXnRdrNP4isk9/7mlpLvYbECAi5IIjuGme6/1YjlzVduh+ms7SP3mcTm5/OzYEuQNdIgBmNRr4Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765176522; c=relaxed/simple;
	bh=lpHLWs60DDkGOjkaWN6AINfcJWgEN4egc4kPZI7xnp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgHj6TdE3yEe15dRu73iz0oKXdJ1FY4yn05quXOrBdH6bksw1T+bPxil9rN8jpQ8qjVRQ9iOYm4qQrwcbnjwq4Ti6rtwREntMDEU9FY3GRciJEe/ZMddVmPxkXwLz08jTuApTEUmGGVb/fGfv4BG24gUHIDRTfDwfNkFj0YpguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccskhqZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47FEC4CEF1;
	Mon,  8 Dec 2025 06:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765176522;
	bh=lpHLWs60DDkGOjkaWN6AINfcJWgEN4egc4kPZI7xnp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ccskhqZ2H5BweNwtQFilMxfuL8cOO1E3C1LHQoKGHPYlJIJm4Y0WJdOAw5awf2GOv
	 RzWUkuDuHKgpuza3UpozMf3ZwejvYFpgMuX8vaUu9vZBYGUef3/1hRRpjeNjEIyMpD
	 8pfN+Yn+fbf1m9iz3PPrCPEbd2vdWMvMuOTL7k5JFp4G/l9i/AgoRjgOqszaT9l5AK
	 nxUp4KRGjBYWaITst3nFr7O2xro4KUuJNLPQiH338LnWSUnLpfoSZhCNQ19Wx80WjW
	 86VbhQZKw+L+wq+Qm/e+X6HdMnAEGRAhH+hhrhaZ4bXWp8iRhSWaTJac8668R/tmFq
	 Rx0PUdZPLV46A==
Date: Mon, 8 Dec 2025 07:48:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH 2/2] pwm: eswin: Add EIC7700 pwm driver
Message-ID: <20251208-wakeful-married-jellyfish-fec14a@quoll>
References: <20251205090411.1388-1-dongxuyang@eswincomputing.com>
 <20251205090509.1501-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205090509.1501-1-dongxuyang@eswincomputing.com>

On Fri, Dec 05, 2025 at 05:05:09PM +0800, dongxuyang@eswincomputing.com wrote:
 + *
> + * Limitations:
> + * - The duty cycle and period cannot both be set to 0.
> + * - The controller hardware provides up to 3 PWM channels.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>

Where do you use half of above headers?

> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/pwm.h>
> +#include <linux/reset.h>
> +
> +#include "pwm-dwc.h"
> +
> +#define DW_PWMS_TOTAL	3
> +
> +static int eic7700_pwm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dwc_pwm_drvdata *data;
> +	struct pwm_chip *chip = NULL;
> +	struct dwc_pwm *dwc = NULL;
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	chip = dwc_pwm_alloc(dev);
> +	if (IS_ERR(chip))
> +		return dev_err_probe(dev, -ENOMEM, "failed to alloc pwm\n");
> +
> +	dwc = to_dwc_pwm(chip);
> +
> +	if (of_property_read_bool(dev->of_node, "snps,pwm-full-range-enable"))
> +		dwc->pwm_0n100_enable = true;
> +
> +	dwc->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dwc->base))
> +		return dev_err_probe(dev, PTR_ERR(dwc->base),
> +				     "failed to get base\n");
> +
> +	dwc->clk = devm_clk_get(dev, NULL);

Just use the enabled varian and drop below prepare enable call.

> +	if (IS_ERR(dwc->clk))
> +		return dev_err_probe(dev, PTR_ERR(dwc->clk),
> +				     "failed to get clock\n");
> +
> +	ret = clk_prepare_enable(dwc->clk);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clock\n");
> +
> +	dwc->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(dwc->rst)) {
> +		dev_err(dev, "failed to get reset control\n");
> +		ret = PTR_ERR(dwc->rst);
> +		goto err_clk_disable;
> +	}
> +
> +	ret = reset_control_deassert(dwc->rst);
> +	if (ret) {
> +		dev_err(dev, "failed to deassert reset: %d\n", ret);
> +		goto err_clk_disable;
> +	}
> +
> +	ret = devm_pwmchip_add(dev, chip);
> +	if (ret) {
> +		dev_err(dev, "failed to add pwmchip: %d\n", ret);
> +		goto err_reset_assert;
> +	}
> +
> +	data->chips[0] = chip;
> +	dev_set_drvdata(dev, data);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_noresume(dev);
> +
> +	return 0;
> +
> +err_reset_assert:
> +	reset_control_assert(dwc->rst);
> +err_clk_disable:
> +	clk_disable_unprepare(dwc->clk);
> +
> +	return ret;
> +}
> +
> +static void eic7700_pwm_remove(struct platform_device *pdev)
> +{
> +	struct dwc_pwm_drvdata *data = platform_get_drvdata(pdev);
> +	struct pwm_chip *chip = data->chips[0];
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +	struct device *dev = &pdev->dev;
> +
> +	clk_disable_unprepare(dwc->clk);
> +	reset_control_assert(dwc->rst);
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +}
> +
> +static int eic7700_pwm_runtime_suspend(struct device *dev)
> +{
> +	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
> +	struct pwm_chip *chip = data->chips[0];
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +	int idx, ret;
> +
> +	for (idx = 0; idx < DW_PWMS_TOTAL; idx++) {
> +		if (chip->pwms[idx].state.enabled)
> +			return -EBUSY;
> +
> +		dwc->ctx[idx].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(idx));
> +		dwc->ctx[idx].cnt2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(idx));
> +		dwc->ctx[idx].ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(idx));
> +	}
> +
> +	clk_disable_unprepare(dwc->clk);
> +	ret = pinctrl_pm_select_sleep_state(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to select sleep state: %d\n", ret);
> +		clk_prepare_enable(dwc->clk);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eic7700_pwm_runtime_resume(struct device *dev)
> +{
> +	struct dwc_pwm_drvdata *data = dev_get_drvdata(dev);
> +	struct pwm_chip *chip = data->chips[0];
> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
> +	int idx, ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to select default state: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(dwc->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	for (idx = 0; idx < DW_PWMS_TOTAL; idx++) {
> +		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt, DWC_TIM_LD_CNT(idx));
> +		dwc_pwm_writel(dwc, dwc->ctx[idx].cnt2, DWC_TIM_LD_CNT2(idx));
> +		dwc_pwm_writel(dwc, dwc->ctx[idx].ctrl, DWC_TIM_CTRL(idx));
> +	}
> +
> +	return 0;
> +}
> +
> +static int eic7700_pwm_suspend(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = eic7700_pwm_runtime_suspend(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eic7700_pwm_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!pm_runtime_suspended(dev)) {
> +		ret = eic7700_pwm_runtime_resume(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops eic7700_pwm_pm_ops = {
> +	RUNTIME_PM_OPS(eic7700_pwm_runtime_suspend, eic7700_pwm_runtime_resume,
> +		       NULL)
> +	SYSTEM_SLEEP_PM_OPS(eic7700_pwm_suspend, eic7700_pwm_resume)
> +};
> +
> +static const struct of_device_id eic7700_pwm_id_table[] = {
> +	{ .compatible = "eswin,eic7700-pwm", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, eic7700_pwm_id_table);
> +
> +static struct platform_driver eic7700_pwm_driver = {
> +	.probe = eic7700_pwm_probe,
> +	.remove = eic7700_pwm_remove,
> +	.driver = {
> +		.name	= "eic7700-pwm",
> +		.pm = pm_sleep_ptr(&eic7700_pwm_pm_ops),
> +		.of_match_table = of_match_ptr(eic7700_pwm_id_table),

Drop of_match_ptr, you have warning here. Look at other drivers how they
do it.

Best regards,
Krzysztof


