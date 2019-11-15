Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F319FD8DA
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2019 10:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOJ1v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Nov 2019 04:27:51 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:63483 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbfKOJ1v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Nov 2019 04:27:51 -0500
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Nov 2019 01:27:45 -0800
IronPort-SDR: XSPeWFqeddtga09FZDEpjbfSgtuLFrdb4IyaS7qWEX6x8rqX/kxnrUhptITFZDp9EL67Q/AJis
 oOrzNIUTs8/rCd7YjqlNf1iWCOtdNuQA2gN9MrMWkujTJUQIkDo4WQMC776Z3T6sGpE3go54Ls
 cAVpnOnGTQz9+sPUwCly9ja144YVyecnj0u5Cx7WgojJm+JjH6CD/yDCsVA21992wvw5bUaFB2
 KhZaFC+mDnHz3y9Mgb5mpirxi+WoeTV8EX5eQHf5sv0VPV2FPk8km0qfjCzOXcGqj1tSpnIN1K
 eVI7eh/4x4X4gT2vjo8BexZE
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 15 Nov 2019 01:27:45 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 65CBB21F5; Fri, 15 Nov 2019 01:27:45 -0800 (PST)
Date:   Fri, 15 Nov 2019 01:27:45 -0800
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Message-ID: <20191115092745.GA21025@codeaurora.org>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
 <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
 <20191016101539.GC1303817@ulmo>
 <20191017060247.GA12487@codeaurora.org>
 <20191017104313.GA3122066@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017104313.GA3122066@ulmo>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On Thu, Oct 17, 2019 at 12:43:13PM +0200, Thierry Reding wrote:
> On Wed, Oct 16, 2019 at 11:02:47PM -0700, Guru Das Srinagesh wrote:
> > On Wed, Oct 16, 2019 at 12:15:39PM +0200, Thierry Reding wrote:
> > > On Tue, Oct 15, 2019 at 07:11:39PM -0700, Guru Das Srinagesh wrote:
> > > > Because period and duty cycle are defined as ints with units of
> > > > nanoseconds, the maximum time duration that can be set is limited to
> > > > ~2.147 seconds. Change their definitions to u64 so that higher durations
> > > > may be set.
> > > > 
> > > > Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
> > > > ---
> > > >  drivers/pwm/core.c  |  4 ++--
> > > >  drivers/pwm/sysfs.c | 10 +++++-----
> > > >  include/linux/pwm.h | 16 ++++++++--------
> > > >  3 files changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > Actually, we can't do that without further preparatory work. The reason
> > > is that consumers use the period and duty_cycle members in computations
> > > of their own, which lead to errors such as this:
> > > 
> > > 	armv7l-unknown-linux-gnueabihf-ld: drivers/video/backlight/pwm_bl.o: in function `pwm_backlight_probe':
> > > 	pwm_bl.c:(.text+0x3b0): undefined reference to `__aeabi_uldivmod'
> > > 
> > > So I think we need to audit all consumers carefully and make sure that
> > > they use do_div() where necessary to avoid such errors.
> > > 
> > > Thierry
> > 
> > Hi Thierry,
> > 
> > I would like to try doing the preparatory work by fixing the errors seen
> > in consumers so that this u64 patch may be applied without issues.
> > 
> > Before sending the patch, I tried "make"-ing for arm, arm64 and i386
> > architectures to check for compilation/linking errors and encountered
> > none. I see that the above error arises from using a cross-compiler for
> > arm v7, which I haven't tried yet.
> > 
> > Could you please provide details of the compile tests that you run at
> > your end? I could then try to reproduce the errors you see in the
> > consumer drivers and fix them. Please do share any other ideas or
> > suggestions you may have in this regard.
> 
> I keep a set of scripts in the pwm/ subdirectory of the following
> repository:
> 
> 	https://github.com/thierryreding/scripts
> 
> Typically what I do is run:
> 
> 	$ /path/to/scripts.git/pwm/build --jobs 13 --color
> 
> That requires a bit of setup for the cross-compilers. I have the
> following in my ~/.cross-compile file:
> 
> 	path: $HOME/pbs-stage1/bin:$HOME/toolchain/avr32/bin:$HOME/toolchain/unicore32/bin
> 	arm: armv7l-unknown-linux-gnueabihf-
> 	arm64: aarch64-unknown-linux-gnu-
> 	avr32: avr32-
> 	blackfin: bfin-unknown-elf-
> 	mips: mips-linux-gnu-
> 	unicore32: unicore32-linux-
> 	riscv: riscv64-linux-gnu-
> 	x86:
> 	x86_64:
> 
> The blackfin and unicore32 builds are expected to fail because the
> blackfin architecture was removed and there's no recent enough kernel
> publicly available for unicore32.
> 
> The last two entries in .cross-compile indicate that builds are native,
> so regular gcc from the build system will be used.
> 
> Most of these compilers I've built from scratch using pbs-stage1:
> 
> 	https://github.com/thierryreding/pbs-stage1
> 
> Note that I don't guarantee that that build system works for anyone but
> myself, but I'd be happy to hear feedback if you decide to use it. That
> said, you can probably find prebuilt toolchains for all of the above in
> a number of locations, like:
> 
> 	https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> or:
> 
> 	https://toolchains.bootlin.com/
> 
> Thierry

I tried replicating your compilation setup and found that it worked
right out of the box with no serious issues. I decided to build the
compilers from scratch and only had to update my make to the latest
version and also install help2man and u-boot-tools on my Ubuntu machine.

I found your setup very easy to use on the whole and very well designed.
I added a "set -x" to the /path/to/scripts.git/build/pwm script in order
to figure out how it worked initially. 

I didn't add the lines for unicore32 and blackfin in my ~/.cross-compile
file as you had indicated that they were expected to fail. It was very
convenient for me to run the build command for a specific arch by
appending its name to the end of the command you provided and thus
verify that the compilation errors I was getting were getting fixed for
that arch. Then by simply dropping the architecture's name from the end
I could run the build command for all archs - very cool.

That said, I wasn't able to compile-test avr32 and x86_64. I couldn't
find avr32 in the targets folder of the pbs-stage1 git repo and so
couldn't build it from scratch, and I couldn't find a pre-built version
either. There isn't a config for x86_64 in
/path/to/scripts.git/pwm/configs and so the build/pwm script wasn't
picking it up even though I had added a blank line for it in
~/.cross-compile. Those are the only two issues I encountered with
replicating your setup.

Thank you.

Guru Das.
