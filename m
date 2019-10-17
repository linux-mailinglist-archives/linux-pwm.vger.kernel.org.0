Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6BDA542
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 08:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392526AbfJQGCt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 02:02:49 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:7489 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392520AbfJQGCt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 02:02:49 -0400
IronPort-SDR: i19YbcRh5VPk31Qa+JZ+UXjWkwxwqsHycbkK2tlRyr55ak/TyxvvWn/tr7i93B3PtSZWyF94Kr
 RhpuQo3evWfAlHragIdMWR5wtEr+CFNK0TbAREIJcqKcpTqL7JrCwj0gNxiW6boB1m3GhfxlZ3
 p9d1iNOSpDqABhPLegSy6ZEcjXN5Eve0qGiwLa3ahPKOsGMxia5aQnlFmkI3xP7MlaxuBcJxqI
 7Ky9bNrqpuS88SB85Vnpka2JhWpoCMLSXYif+PcW5YktDFGBj5rhKFy/FkBI9uWy/sz3UIwiaX
 e6A=
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Oct 2019 23:02:48 -0700
IronPort-SDR: ernh8agRQqL4TbhwNG80wQJkqZ3pFDc7Bzt9df8rc98IEKe3cVFhXcQmH2OYtYTsU+Ox7tJrye
 keMV9wsHlxK+C8iEMpWul5uzrYYJEYomwJ9kuq8xX6TrK9GPZ6bXJ1wHrGkN2UZ7hut8dv4zFl
 bsnDS8O0hhG+Qvs0EMBJpVtyK2bf7eHh+cThRZpEVJ+OhSa5axS8N3qSxJfksVOSacgR7NSkJP
 DRHS819snjeOXHJMAqaMalQ/z7BIysoTNEh1A1oFG6JOpVqrxXFCRjQB+n2MN8DnyLcumlU4ZA
 5V7RfsyedDhDcoWb1Z6LgIof
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 16 Oct 2019 23:02:48 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id DAC6C475A; Wed, 16 Oct 2019 23:02:47 -0700 (PDT)
Date:   Wed, 16 Oct 2019 23:02:47 -0700
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20191017060247.GA12487@codeaurora.org>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
 <20191016101539.GC1303817@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016101539.GC1303817@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 16, 2019 at 12:15:39PM +0200, Thierry Reding wrote:
> On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> > Because period and duty cycle are defined as ints with units of
> > nanoseconds, the maximum time duration that can be set is limited to
> > ~2.147 seconds. Change their definitions to u64 so that higher durations
> > may be set.
> > 
> > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > ---
> >  drivers/pwm/core.c  |  4 ++--
> >  drivers/pwm/sysfs.c | 10 +++++-----
> >  include/linux/pwm.h | 16 ++++++++--------
> >  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> Actually, we can't do that without further preparatory work. The reason
> is that consumers use the period and duty_cycle members in computations
> of their own, which lead to errors such as this:
> 
> 	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.o: in function `pwm_backlight_probe':
> 	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> 
> So I think we need to audit all consumers carefully and make sure that
> they use do_div() where necessary to avoid such errors.
> 
> Thierry

Hi Thierry,

I would like to try doing the preparatory work by fixing the errors seen
in consumers so that this u64 patch may be applied without issues.

Before sending the patch, I tried "make"-ing for arm, arm64 and i386
architectures to check for compilation/linking errors and encountered
none. I see that the above error arises from using a cross-compiler for
arm v7, which I haven't tried yet.

Could you please provide details of the compile tests that you run at
your end? I could then try to reproduce the errors you see in the
consumer drivers and fix them. Please do share any other ideas or
suggestions you may have in this regard.

Thank you.

Guru Das.
