Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB177D5D62
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Oct 2023 23:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbjJXVmH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Oct 2023 17:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjJXVmG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Oct 2023 17:42:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FEA6;
        Tue, 24 Oct 2023 14:42:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB058C433C7;
        Tue, 24 Oct 2023 21:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698183724;
        bh=DzV7ghoLMlexYVGjdHsJAxVtsFLNbQK28PLda36BUz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvAT6Wh7jGiuXX/88AYtyNprbNyn1pgQuhjV2t8A7ZEPj5PM10kXfhV5JPs/DoeUp
         W7zsHIDZ5wRIiu7CYVkhKE79CxazVoWaNdeHiQl4y5FlbhDb0j12TDAe+x00gxl9W/
         TCy63h3FworHiWz8R9Xkqn9fvSKdiRbTzoneXdF7A6sHNg4mGQ3FYjqqG/yegOsp6Y
         oHeDRpNwbZttZ7ww093xKLJtvHsSIdNzg1uAB0NcoJQaoZ0ZI5NczN3fftlAr4Ie9i
         EsHPEegbf5uj7toxxvXgdw6JFw7knCv0EvBm5uA2xo08NaJMYaDCy5Yh7KuL/IfqE6
         vUZzY8BCopAig==
Date:   Tue, 24 Oct 2023 23:42:00 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 07/11] pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for
 PM functions
Message-ID: <20231024214200.ynopmioczylqaibu@zenone.zhora.eu>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
 <20231023174616.2282067-20-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023174616.2282067-20-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Oct 23, 2023 at 07:46:24PM +0200, Uwe Kleine-König wrote:
> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
> #ifdef can be dropped.
> 
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
