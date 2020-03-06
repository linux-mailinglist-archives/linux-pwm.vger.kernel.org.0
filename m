Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D65F417B763
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 08:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgCFH2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 02:28:17 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58489 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCFH2R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Mar 2020 02:28:17 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7Ov-0007jV-SA; Fri, 06 Mar 2020 08:28:05 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jA7Ov-0003pl-7B; Fri, 06 Mar 2020 08:28:05 +0100
Date:   Fri, 6 Mar 2020 08:28:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Sandipan Patra <spatra@nvidia.com>
Cc:     treding@nvidia.com, robh+dt@kernel.org, jonathanh@nvidia.com,
        bbasu@nvidia.com, ldewangan@nvidia.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: tegra: Add support for Tegra194
Message-ID: <20200306072805.qraegjo7xmebelu5@pengutronix.de>
References: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1583407653-30059-1-git-send-email-spatra@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Mar 05, 2020 at 04:57:33PM +0530, Sandipan Patra wrote:
> Tegra194 has multiple PWM controllers with each having only one output.
> 
> Also the maxmimum frequency is higher than earlier SoCs.
> 
> Add support for Tegra194 and specify the number of PWM outputs and
> maximum supported frequency using device tree match data.
> 
> Signed-off-by: Sandipan Patra <spatra@nvidia.com>

Looks good to me,

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
