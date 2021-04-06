Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B5C354FF6
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Apr 2021 11:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237428AbhDFJdo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 6 Apr 2021 05:33:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:14984 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236696AbhDFJdn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Apr 2021 05:33:43 -0400
IronPort-SDR: nAQjvgOFpT76wHt/4rwAtdtVM+I8aU2LkBV0j3hYQEzISCCMCT9ZyS0fQq/9qKYWSduU4RCbMx
 TwZF7dbCmFTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="172502141"
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="172502141"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 02:33:34 -0700
IronPort-SDR: yNx+NRizR5mkR8GcZPzlI8J7Pj0MjByUv03J9PMpLpN8+8z9CtxNE4aHX/zeWYKFAFUMA0T4x4
 hC15JwVa90TA==
X-IronPort-AV: E=Sophos;i="5.81,309,1610438400"; 
   d="scan'208";a="457817452"
Received: from oowomilo-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.33.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 02:33:03 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] pwm: Rename pwm_get_state() to better reflect its semantic
In-Reply-To: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20210406073036.26857-1-u.kleine-koenig@pengutronix.de>
Date:   Tue, 06 Apr 2021 12:32:58 +0300
Message-ID: <87tuojlpv9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 06 Apr 2021, Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> Given that lowlevel drivers usually cannot implement exactly what a
> consumer requests with pwm_apply_state() there is some rounding involved.
>
> pwm_get_state() traditionally returned the setting that was requested most
> recently by the consumer (opposed to what was actually implemented in
> hardware in reply to the last request). To make this semantic obvious
> rename the function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

>  drivers/gpu/drm/i915/display/intel_panel.c |  4 +--

Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel Open Source Graphics Center
